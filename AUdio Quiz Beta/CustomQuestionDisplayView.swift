//
//  CustomQuestionDisplayView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/23/24.
//

import SwiftUI

struct CustomQuestionDisplayView: View {
    @State var isAnswered: Bool = false
    @State private var viewUpdateID = UUID()
    @ObservedObject var quizPlayer = QuizPlayer()
    
    var speechManager = SpeechManager()
    var hideText: () -> Void

    var body: some View {
            
            if let questionModel = quizPlayer.currentQuestion  {
                
                VStack(spacing: 10) {
                    //MARK: Quiz Info Details View
                    QuizInfoDetailsView()
                        .frame(alignment: .topLeading)
                    
                    //MARK: Quiz Visualizer
                    HStack {
                        Text(quizPlayer.questionCounter)
                            .font(.callout)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    
                    //MARK: Question Content View
                    Text("\(questionModel.questionContent)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(!isAnswered ? .black : .gray)
                        .lineLimit(6, reservesSpace: true)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .onChange(of: questionModel.questionContent, initial: isAnswered) { oldValue,_ in
                            updateView()
                        }
                    
                    ForEach(questionModel.options, id: \.self) { option in
                        optionButton(questionModel: questionModel, option: option)
                    }
                    
                    FullScreenControlView(isNowPlaying: true, quizPlayer: quizPlayer, showQuizControl: {})
                    
                }
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            } else {
                
                ContentUnavailableView(
                    "You Haven't built a Quiz yet",
                    systemImage: "book.and.wrench.fill",
                    description: Text("You need to buld a quiz to see the questions")
                )
            }
    }
    
    private func updateView() {
        isAnswered.toggle()
    }
    
    @ViewBuilder
    private func optionButton(questionModel: TestQuestionModel, option: String) -> some View {
        let optionColor = colorForOption(option: option, correctOption: questionModel.correctOption, userAnswer: "\(questionModel.selectedOption)")
        
        Button(action: {
            questionModel.selectedOption = option
            isAnswered.toggle()
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
        .disabled(isAnswered && option != questionModel.selectedOption)
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


#Preview {
    CustomQuestionDisplayView(hideText: {})
}
