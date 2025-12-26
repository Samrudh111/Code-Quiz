//
//  FavoritesPageView.swift
//  CodeQuiz
//
//  Created by Samrudh S on 12/24/25.
//

import SwiftUI

struct FavoritesPageView: View {
    @State private var questionList = ["Q1", "Q2jfsofjsjfowiefoiwnfwononifnwoinfondfsfsdf"]
    
    var body: some View {
        NavigationStack{
            List(questionList, id: \.self){ question in
                Button {
                    
                } label: {
                    FavoritesQuestionListButton(questionTitle: question)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        // Execute task once the user deletes this item
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}

struct FavoritesQuestionListButton: View {
    var questionTitle: String
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text("Topic - Category")
                    .font(.custom("", size: 10))
                    .foregroundStyle(.secondary)
                    Text(questionTitle)
            }
            .padding(.horizontal, 5)
            .foregroundStyle(.black)
            Spacer()
            Button {
                // Execute task once the user unHeart this item
            } label: {
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16)
            }.foregroundStyle(.red)
        }
    }
}

#Preview {
    FavoritesPageView()
}
