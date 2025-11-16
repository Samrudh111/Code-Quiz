//
//  HomepageView.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/6/25.
//

import SwiftUI
import SwiftData

struct HomepageView: View {
    @State var levelWeight: Int?
    @State var languageSelected: Language?
    @State var category: String?
    // can save the above values to an object?
    private let languagesList = Language.allCases.sorted(by: { $0.rawValue < $1.rawValue })
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    @State var doNotScroll = true
    @Environment(TestProperties.self) var testProperties
    @State var showErrorMessage = false
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView{
                    
                    // "Continue where u left? or start a new test"
                    
                    VStack(spacing: 10){
                        VStackLayout(alignment: .leading){
                            Text("Difficulty Level")
                                .font(.custom("Exo2-Regular", size: 24))
                                .padding(.vertical, 10)
                            HStack(spacing: 10){
                                ForEach(DifficultyLevel.allCases, id: \.self){ level in
                                    LevelButtonView(level: level, levelSelected: $levelWeight)
                                }
                            }.padding(.bottom, 10)
                        }
                        .frame(height: 160)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        
                        VStack(alignment: .leading){
                            Text("Programming Languae")
                                .font(.custom("Exo2-Regular", size: 24))
                                .padding(.vertical, 10)
                                .padding(.leading, 40)
                            VStack(spacing: -12){
                                HStack(spacing: 1){
                                    ForEach(languagesList.prefix(upTo: 3), id: \.self){ pl in
                                        LanguagePickerView(language: pl, isFirstRow: true, languageSelected: $languageSelected)
                                    }
                                }
                                HStack(spacing: 1){
                                    ForEach(languagesList.dropFirst(3), id: \.self){ pl in
                                        LanguagePickerView(language: pl, isFirstRow: false, languageSelected:  $languageSelected)
                                    }
                                }
                            }
                            VStack{
                                if let languageSelected = languageSelected{
                                    LazyVGrid(columns: columns) {
                                        CategoryButtonView(category: "Random 15", bgColor: languageSelected.backgroundColor, categorySelected: $category) // Change border color for this button
                                        ForEach(languageSelected.categories, id: \.self){ category in
                                            CategoryButtonView(category: category, bgColor: languageSelected.backgroundColor, categorySelected: $category)
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }.scrollDisabled(languageSelected == nil)
                
                if showErrorMessage {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                        Text("Please select all required fields.")
                    }
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.red.opacity(0.9))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .padding(.horizontal, 16)
                    .shadow(radius: 6)
                    .offset(y: 250)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                VStack{
                    Spacer()
                    Button {
                        beginTest()
                    } label: {
                        Text("BEGIN !")
                            .font(.custom("Exo2-Black", size: 30))
                        // SHow loading circle while retrieving quiz and disable the button touch
                    }
                    .buttonStyle(.glassProminent)
                }
            }
            .animation(.spring(response: 0.35, dampingFraction: 0.4), value: showErrorMessage)
            .navigationTitle("CodeQuiz")
            .background(.green)
        }
        .onAppear{
            if UserDefaults.standard.data(forKey: "AllQuestionSet") == nil {
                DispatchQueue.main.async {
                    fetchQuestionSets()
                }
            }
        }
    }
    
    private func beginTest(){
        guard let _ = levelWeight, let _ = languageSelected else{ // if no category selected, choose random set
            showErrorMessage = true // !! not showing in landscape mode
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showErrorMessage = false
            }
            return
        }
        prepareQuestionSet()
    }
    
    private func prepareQuestionSet(){
        guard let allQuestions = UserDefaults.standard.data(forKey: "AllQuestionSet") else {
            // Still downloading the questions indicator
            return
        }
        let questionsData = try? JSONDecoder().decode(Root.self, from: allQuestions)
        let swiftTopics = questionsData!.data.swift
        
        // 1. Pick the correct DifficultySet for the chosen category
        let topicSet: DifficultySet
        switch category {
        case "Swift UI":
            topicSet = swiftTopics.swiftUI
        case "UIKit":
            topicSet = swiftTopics.uiKit
        case "AppKit":
            topicSet = swiftTopics.appKit
        case "Storyboard":
            topicSet = swiftTopics.storyboard
        case "Async/Await":
            topicSet = swiftTopics.asyncAwait
        case "URLSession":
            topicSet = swiftTopics.urlSession
        default:
            return
        }
        
        // 2. Pick the correct difficulty array (Easy / Medium / Hard)
        let questionSet: [QA]
        switch levelWeight {
        case 1:
            questionSet = topicSet.easy
        case 2:
            questionSet = topicSet.medium
        case 3:
            questionSet = topicSet.hard
        default:
            return
        }
        let encoded = try? JSONEncoder().encode(questionSet)
        UserDefaults.standard.set(encoded, forKey: "QuestionSet")
        UserDefaults.standard.set(true, forKey: "QuizActive")
    }
    
    private func fetchQuestionSets(){
        guard let dataUrl = Bundle.main.url(forResource: "QuestionsDataset", withExtension: "json"),
              let rawData = try? Data(contentsOf: dataUrl) else{ return }
        UserDefaults.standard.set(rawData, forKey: "AllQuestionSet")
    }
}

//MARK: - Difficulty level Button view
struct LevelButtonView: View {
    let level: DifficultyLevel
    @Binding var levelSelected: Int?
    private var doHighlight: Bool{ return (level.weightage == levelSelected) }
    
    var body: some View {
        Button {
            doHighlight ? (levelSelected = nil) : (levelSelected = level.weightage)
        } label: {
            HStack{
                Text(level.rawValue)
                    .font(.custom("Exo2-Black", size: 25))
                    .foregroundStyle(doHighlight ? Color.white : Color.black)
            }
            .padding(4)
        }
        .buttonStyle(.glassProminent)
    }
}

// MARK: - Language box view
struct LanguagePickerView: View {
    let language: Language
    var isFirstRow = false
    @Binding var languageSelected: Language?
    private var doHighlight: Bool{ return (language == languageSelected) }
    
    var body: some View {
        Button {
            doHighlight ? (languageSelected = nil) : (languageSelected = language)
        } label: {
            HStack{
                Image(language.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 35)
                Text(language.rawValue)
                    .font(.custom("Exo2-Regular", size: 18))
                    .foregroundStyle(Color.black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(doHighlight ? language.backgroundColor : (isFirstRow ? Color(red: 214/255, green: 214/255, blue: 214/255) : Color(red: 235/255, green: 235/255, blue: 235/255)))
            .shadow(radius: 2, y: -3)
        }
    }
}

// MARK: - Category button view
struct CategoryButtonView: View {
    let category: String
    let bgColor: Color
    @Binding var categorySelected: String?
    private var doHighlight: Bool{ return (category == categorySelected) }
    
    var body: some View {
        Button {
            doHighlight ? (categorySelected = nil) : (categorySelected = category)
        } label: {
            HStack{
                Text(category)
                    .font(.custom("Exo2-Regular", size: 15))
                    .foregroundStyle(doHighlight ? bgColor : Color.white) // update the fgcolor
            }
            .padding(10)
            .background(doHighlight ? .white.opacity(0.8) : bgColor, in: .capsule)
            .overlay {
                Capsule().stroke(lineWidth: 2)
                    .foregroundStyle(bgColor)
            }
        }
    }
}

#Preview{
    let testprop = TestProperties()
    HomePageGroup()
        .environment(testprop)
}
