//
//  QAPageView.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/9/25.
//

import SwiftUI

struct QAPageView: View {
    @State private var index = 0
    @Environment(TestProperties.self) private var testProperties
    @State var cardDegree = 0.0
    @State var contentDegree = 0.0
    @State var questionSet: [QA]?
    
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
                    MenuView()
                }
                ToolbarItem(placement: .topBarLeading) {
                    ExitButton {
                        UserDefaults.standard.set(false, forKey: "QuizActive")
                        testProperties.questionNumber = 1
                    }
                }
            }
            .overlay {
                NavigateQuestionButtons(cardDegree: $cardDegree, contentDegree: $contentDegree, index: $index)
            }
        }
        .onAppear{
            questionSet = fetchFromUserDefaults()
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
    
    @ViewBuilder
    func QACard(for index: Int) -> some View {
        ZStack{
            if let questionSet = questionSet{
                QuestionCard(question: questionSet[index].question)
                ScrollView{
                    VStack{
                        //Text("Language - and its category name should be displayed here")
                        AnswersCard(answerSet: questionSet[index].options)
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

struct AnswersCard: View {
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

struct MenuView: View {
    @Environment(TestProperties.self) private var testProperties
    var body: some View {
        Menu {
            ForEach(1...5, id: \.self) { q in
                Button {
                    testProperties.questionNumber = q
                } label: {
                    Text((String(q)))
                }
            }
        } label: {
            HStack{
                Text("Question \(testProperties.questionNumber) ")
                    .font(.custom("Exo2-Light", size: 22))
                Image(systemName: "list.bullet")
            }
        }
    }
}

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

struct NavigateQuestionButtons: View {
    @Binding var cardDegree: Double
    @Binding var contentDegree: Double
    @Environment(TestProperties.self) private var testProperties
    @Binding var index: Int

    var body: some View {
        VStack{
            Spacer()
            HStack{
                PrevNextButton(isNextButton: false)
                Spacer()
                PrevNextButton(isNextButton: true)
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
                isNextButton ? (testProperties.questionNumber += 1) : (testProperties.questionNumber -= 1)
                isNextButton ? (index += 1) : (index -= 1) // remove this
            }
        } label: {
            Image(systemName: isNextButton ? "chevron.right" : "chevron.left")
        }
        .buttonStyle(.glass)
        .padding()
        .disabled((testProperties.questionNumber == 1) && (!isNextButton))
    }
}

#Preview {
    let testprop = TestProperties()
    HomePageGroup()
        .environment(testprop)
}
