//
//  QAPageAIMode.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/30/25.
//

import SwiftUI

struct QAPageViewAIMode: View {
    @State private var index: Int = 0
    @State var cardDegree = 0.0
    @State var contentDegree = 0.0
    @State var questionSet: [QA] = []
    @State var questionSetAI: [QAai] = []
    
    @State var testObject = TestObject(levelWeight: 1, languageSelected: "Unknown", category: "Unknown")
    @State var userChoices = [Int : Int]()
    
    @EnvironmentObject var quizVM: QuizViewModel
    
    var body: some View {
        NavigationStack{
            Group {
                if quizVM.isLoading {
                    VStack {
                        ProgressView()
                        Text("Generating quiz…")
                            .padding(.top, 8)
                    }
                } else if let error = quizVM.errorMessage {
                    VStack(spacing: 16) {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            UserDefaults.standard.set(false, forKey: "QuizActive")
                        }
                    }
                } else if quizVM.questions.isEmpty {
                    Text("No questions loaded.")
                    Button("Exit") {
                        UserDefaults.standard.set(false, forKey: "QuizActive")
                    }
                } else {
                        ZStack{
                            QACardAi(index: $index, testObject: testObject, questionSet: questionSetAI, userChoices: $userChoices)
                                .id(index)
                                .rotation3DEffect(.degrees(contentDegree), axis: (x: 0, y: 1, z: 0))
                        }
                        .rotation3DEffect(.degrees(cardDegree), axis: (x: 0, y: 1, z: 0))
                        .toolbar(.hidden, for: .tabBar)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                MenuView(cardDegree: $cardDegree, contentDegree: $contentDegree, index: $index, questionCount: questionSetAI.count)
                            }
                            ToolbarItem(placement: .topBarLeading) {
                                ExitButton {
                                    UserDefaults.standard.set(false, forKey: "QuizActive")
                                    //UserDefaults.standard.set([], forKey: "QuestionSet")
                                    //UserDefaults.standard.removeObject(forKey: "")
                                    // Are u sure u want to finish the test ? popup
                                }
                            }
                        }
                        .overlay {
                            NavigateQuestionButtons(cardDegree: $cardDegree, contentDegree: $contentDegree, index: $index, questionCount: questionSetAI.count)
                        }
                        .onAppear{
                            //questionSet = fetchFromUserDefaults()
                            questionSetAI = fetchFromAIMode()
                            //testObject = getCategoryLabel()
                            userChoices = Dictionary(uniqueKeysWithValues: (0..<questionSetAI.count).map { ($0, -1) })
                        }
                    }
            }
        }
    }
    
    private func fetchFromUserDefaults() -> [QA]{
        let data = UserDefaults.standard.data(forKey: "QuestionSet")
        var questionSet: [QA] = []
        
        if let data = data{
            questionSet = try! JSONDecoder().decode([QA].self, from: data)
            //            for i in questionSet.indices{
            //                let correctOption = questionSet[i].options[0]
            //                questionSet[i].options.shuffle()
            //                correctOptionsArray.append(questionSet[i].options.firstIndex(of: correctOption) ?? 0)
            //
            //                // can store this correct option index in the QA object itself..
            //
            //            }
        }
        return questionSet
    }
    
    private func fetchFromAIMode() -> [QAai]{
        return quizVM.questions
    }
    
    private func getCategoryLabel() -> TestObject{
        let data = UserDefaults.standard.data(forKey: "TestObject")
        if let data = data{
            return (try? JSONDecoder().decode(TestObject.self, from: data))!
        }
        return TestObject()
    }
}

//MARK: - QACard
struct QACardAi: View{
    @Binding var index: Int
    @State var showExplanation = false
    let testObject: TestObject
    let questionSet: [QAai]
    @State var isliked = false
    @Binding var userChoices: [Int : Int]
    
    var body: some View{
        ZStack{
            if !questionSet.isEmpty{
                QuestionCard(question: questionSet[index].question)
                ScrollView{
                    ZStack{
                        if showExplanation{
                            VStack{
                                Text(questionSet[index].explanation ?? "Sorry. Explanation unavailable..")
                                    .font(.custom("Exo2-Medium", size: 25))
                                    .foregroundStyle(.black)
                                    .padding()
                                Button {
                                    showExplanation = false
                                } label: {
                                    Text("Close")
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 1000, alignment: .top) // need to check this height
                            .background(.green,in: .rect(cornerRadius: 35))
                            .offset(y: 350)
                        } else{
                            VStack{
                                Text("\(testObject.category!)  -  \(testObject.languageSelected!)  -  Level \(testObject.levelWeight!)")
                                    .font(.custom("Exo2-Medium", size: 12))
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 18)
                                    .foregroundStyle(.white)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(.black))
                                    .padding(8)
                                HStack{
                                    Spacer()
                                    Button {
                                        withAnimation(.easeOut(duration: 0.5)) {
                                            showExplanation = true
                                        }
                                    }label: {
                                        Text("Explanation > >")
                                            .font(.custom("Exo2-Medium", size: 12))
                                            .frame(width: 110, height: 20)
                                            .background(Rectangle()
                                                .fill(.yellow)
                                                .shadow(radius: 2, x: 3, y: 3))
                                    }
                                    .opacity((userChoices[index] == -1) ? 0 : 1)
                                    .padding(.trailing, 75)
                                    .padding(.bottom, 8)
                                }
                                OptionsCardAi(answerSet: questionSet[index].options, correctOption: questionSet[index].correctOptionIndex, index: $index, userChoices: $userChoices)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 1000, alignment: .top) // need to check this height
                            .background(RoundedRectangle(cornerRadius: 35)
                                .fill(.white)
                                .shadow(color: .white.opacity(0.6), radius: 25))
                            .offset(y: 350)
                            .overlay {
                                Button {
                                    isliked.toggle()
                                } label: {
                                    Image(systemName: isliked ? "heart.fill" : "heart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: isliked ? 20 : 22)
                                        .foregroundStyle(isliked ? .pink : .black)
                                        .symbolEffect(.bounce.up.byLayer, options: .nonRepeating)
                                }
                                .offset(x: 160, y: -120)
                            }
                        }
                    }
                }
                .scrollIndicators(.never)
                // disable interaction during transition
                //.scrollDisabled for showExplanation
            }else{
                // Error fetching screen
            }
            //.scrollShowDisabled(false)
        }
    }
}

//MARK: - Question Card
struct QuestionCardAi: View {
    var question: String?
    
    var body: some View {
        Text(question ?? "Error fetching Questions")
            .font(.custom("GoogleSansCode-Medium", size: 15))
            .padding(25)
            .frame(maxHeight: .infinity, alignment: .top)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.white)
            .multilineTextAlignment(.leading)
            .background(.black)
    }
}

//MARK: - Options Card
struct OptionsCardAi: View {
    let answerSet: [String]?
    @State var correctOption: Int
    @Binding var index: Int
    @Binding var userChoices: [Int : Int]
    @State var wrongOption = -1
    
    var body: some View {
        VStack(spacing: 15){
            if let optionSet = answerSet{
                ForEach(optionSet, id: \.self){ option in
                    optionView(optionSet: optionSet, option: option)
                }
            }
        }
        .onAppear{
            checkCorrectOption(for: userChoices[index] ?? -1)
        }
    }
    
    private func checkCorrectOption(for userSelectedOption: Int){
        if userSelectedOption != -1 {
            if userSelectedOption != correctOption{
                wrongOption = userSelectedOption
            }
        }
    }
    
    @ViewBuilder
    private func optionView(optionSet: [String], option: String) -> some View{
        let optionIndex = optionSet.firstIndex(of: option)
        var showStroke = false
        let optionColor: Color = {
            if (userChoices[index] != -1){
                if(optionIndex == correctOption){
                    return Color.green
                } else if userChoices[index] == optionIndex{
                    if wrongOption != -1{
                        showStroke = true
                        return Color.white
                    }
                }
            }
            return Color.white
        }()
        
        Button {
            userChoices[index] = optionIndex
            checkCorrectOption(for: optionIndex ?? -1)
        } label: {
            Text(option)
                .font(.custom("Exo2-Medium", size: 15))
                .padding(.horizontal, 10)
                .frame(width: 260, height: 50)
                .foregroundStyle(.black)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(optionColor)
                    .shadow(color: showStroke ? .red : .black, radius: 3, x: 3, y: 3))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(showStroke ? Color.red : Color.black, lineWidth: showStroke ? 2.5 : 1)
                }
        }
        .disabled((userChoices[index]) != -1)
    }
}

//MARK: - Menu View
struct MenuViewAi: View {
    @Binding var cardDegree: Double
    @Binding var contentDegree: Double
    @Binding var index: Int
    let questionCount: Int
    let animTime = 0.7
    
    var body: some View {
        Menu {
            ForEach(0..<questionCount, id: \.self) { qNumber in
                Button {
                    withAnimation(.linear(duration: 0.001).delay(animTime/2)) {
                        if qNumber > index{
                            contentDegree -= 180
                        } else if qNumber < index{
                            contentDegree += 180
                        }
                        // rotates fast!
                    }
                    withAnimation(.easeOut(duration: animTime)) {
                        if qNumber > index{
                            cardDegree -= 180
                        } else if qNumber < index{
                            cardDegree += 180
                        }
                        index = qNumber
                    }
                } label: {
                    HStack{
                        Text((String(qNumber+1)))
                        if index == qNumber{
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack{
                Text("Question \(index+1) ")
                    .font(.custom("Exo2-Light", size: 22))
                Image(systemName: "list.bullet")
            }
        }
    }
}

//MARK: - Exit Button
struct ExitButtonAi: View {
    var onTapAction: () -> Void
    
    var body: some View {
        Button {
            onTapAction()
        } label: {
            HStack{
                Image(systemName: "arrowtriangle.backward.fill")
                    .resizable()
                    .frame(width: 13, height: 13)
                Text("Exit")
                    .font(.custom("Exo2-Light", size: 22))
            }
            .foregroundStyle(.red)
        }
    }
}

//MARK: - Navigate Buttons
struct NavigateQuestionButtonsAi: View {
    @Binding var cardDegree: Double
    @Binding var contentDegree: Double
    @Binding var index: Int
    let questionCount: Int
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                PrevNextButton(isNextButton: false)
                    .opacity((index == 0) ? 0 : 1)
                Spacer()
                PrevNextButton(isNextButton: true)
                    .opacity(index == questionCount-1 ? 0 : 1)
            }
        }
    }
    
    @ViewBuilder
    private func PrevNextButton(isNextButton: Bool) -> some View{
        let animTime = 0.7
        Button {
            withAnimation(.linear(duration: 0.001).delay(animTime/2)) {
                isNextButton ? (contentDegree -= 180) : (contentDegree += 180)
            }
            withAnimation(.easeOut(duration: animTime)) {
                isNextButton ? (cardDegree -= 180) : (cardDegree += 180)
                isNextButton ? (index += 1) : (index -= 1)
            }
        } label: {
            Image(systemName: isNextButton ? "chevron.right" : "chevron.left")
        }
        .buttonStyle(.glass)
        .padding()
    }
}

#Preview {
    HomePageGroup()
}
