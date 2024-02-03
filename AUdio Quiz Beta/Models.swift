//
//  Models.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/25/24.
//

import Foundation
import SwiftUI

struct OptionButton: View {
    @ObservedObject var questionModel: Question
    @State var selectedOption: String = ""
    var option: String
    var quizPlayer: QuizPlayer
    var buttonAction: () -> Void// Assuming you have a QuizPlayer class

    var body: some View {
        let optionColor = colorForOption(option: option, correctOption: questionModel.correctOption, userAnswer: quizPlayer.selectedOption)
        
        Button(action: {
            questionModel.selectedOption = option
            
            
            
            //quizPlayer.saveAnswer(for: questionModel.id, answer: questionModel.selectedOption)
            
        }) {
            Text(option)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(optionColor.opacity(0.15)))
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(optionColor.opacity(optionColor == .black ? 0.15 : 1), lineWidth: 2)
                }
        }
        //.disabled(questionModel.selectedOption != "" && option != questionModel.selectedOption)
    }
    
    private func colorForOption(option: String, correctOption: String, userAnswer: String) -> Color {
        
        if userAnswer.isEmpty {
            return .black
        } else if option == correctOption {
            return .green
        } else if option == userAnswer {
            return .red
        } else {
            return .black
        }
    }
}


struct QuizInfoDetailsView: View {
    @State var shortName: String = "Practice Quiz"
    @State var longName: String = "New York Bar Exam"
    @State var iconImage: String = "IconImage"

    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            /// Exam Icon Image
            Image(iconImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            
            VStack(alignment: .leading, spacing: 4) {
                /// Short Name
                Text(shortName)
                    .foregroundStyle(.black)
                    .opacity(0.6)
                /// Long Name
                Text(longName)
                    .font(.title3)
                    .foregroundStyle(.themePurple)
                    .fontWeight(.semibold)
                    .lineLimit(2, reservesSpace: true)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

