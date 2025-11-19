//
//  QAPageView.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/9/25.
//

import SwiftUI

struct QAPageView: View {
    @State private var index = 0
    @State var cardDegree = 0.0
    @State var contentDegree = 0.0
    @State var questionSet: [QA] = []
    @State var testObject = TestObject(levelWeight: 1, languageSelected: "Unknown", category: "Unknown")
    
    var body: some View {
        NavigationStack{
            
            // Show quiz setting like level and language
            
            ZStack{
                QACard(for: index)
                    .id(index)
                    .rotation3DEffect(.degrees(contentDegree), axis: (x: 0, y: 1, z: 0))
            }
            .rotation3DEffect(.degrees(cardDegree), axis: (x: 0, y: 1, z: 0))
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    MenuView(index: $index, questionCount: questionSet.count)
                }
                ToolbarItem(placement: .topBarLeading) {
                    ExitButton {
                        UserDefaults.standard.set(false, forKey: "QuizActive")
                        //UserDefaults.standard.set([], forKey: "QuestionSet")
                    }
                }
            }
            .overlay {
                NavigateQuestionButtons(cardDegree: $cardDegree, contentDegree: $contentDegree, index: $index, questionCount: questionSet.count)
            }
        }
        .onAppear{
            questionSet = fetchFromUserDefaults()
            testObject = getCategoryLabel()
        }
    }
    
    private func fetchFromUserDefaults() -> [QA]{
        let data = UserDefaults.standard.data(forKey: "QuestionSet")
        var questionSet: [QA] = []
        if let data = data{
            questionSet = try! JSONDecoder().decode([QA].self, from: data)
        }
        return questionSet
    }
    
    private func getCategoryLabel() -> TestObject{
        let data = UserDefaults.standard.data(forKey: "TestObject")
        if let data = data{
            return (try? JSONDecoder().decode(TestObject.self, from: data))!
        }
        return TestObject()
    }
    
    @ViewBuilder
    private func QACard(for index: Int) -> some View {
        ZStack{
            if !questionSet.isEmpty{
                QuestionCard(question: questionSet[index].question)
                ScrollView{
                    VStack{
                        Text("\(testObject.category!) - \(testObject.languageSelected!) - Level \(testObject.levelWeight!)")
                        OptionsCard(answerSet: questionSet[index].options)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 1000, alignment: .top) // need to check this height
                    .background(.white)
                    .offset(y: 400)
                }
            }else{
                // Error fetching screen
            }
            //.scrollDisabled(false)
        }
    }
}

//MARK: -Question Card
struct QuestionCard: View {
    var question: String?
    
    var body: some View {
        Text(question ?? "Error fetching Questions")
            .font(.custom("GoogleSansCode-Medium", size: 13))
            .padding(15)
            .frame(maxHeight: .infinity, alignment: .top)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.white)
            .background(.black)
    }
}

//MARK: -Options Card
struct OptionsCard: View {
    let answerSet: [String]?
    
    var body: some View {
        VStack{
            if let optionSet = answerSet{
                ForEach(optionSet, id: \.self){ options in
                    Text(options)
                }
            }
        }
    }
}

//MARK: -Menu View
struct MenuView: View {
    @Environment(TestProperties.self) private var testProperties
    @Binding var index: Int
    let questionCount: Int
    
    var body: some View {
        Menu {
            ForEach(0..<questionCount, id: \.self) { qNumber in
                Button {
                    index = qNumber
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

//MARK: -Exit Button
struct ExitButton: View {
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

//MARK: -Navigate Buttons
struct NavigateQuestionButtons: View {
    @Binding var cardDegree: Double
    @Binding var contentDegree: Double
    @Environment(TestProperties.self) private var testProperties
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
                isNextButton ? (index += 1) : (index -= 1) // remove this
            }
        } label: {
            Image(systemName: isNextButton ? "chevron.right" : "chevron.left")
        }
        .buttonStyle(.glass)
        .padding()
    }
}

#Preview {
    let testprop = TestProperties()
    HomePageGroup()
        .environment(testprop)
}
