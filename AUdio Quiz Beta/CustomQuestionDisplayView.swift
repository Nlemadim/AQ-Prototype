//
//  CustomQuestionDisplayView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/23/24.
//

import SwiftUI

struct CustomQuestionDisplayView: View {
    @State private var questionIndex: Int = 0
    
    @State private var isNowPlaying: Bool = false
    @State var tester: Bool = false
    @ObservedObject var quizPlayer = QuizPlayer()
    
    var speechManager = SpeechManager()
    var hideText: () -> Void
    
    private var recording: Bool  {
        quizPlayer.isRecordingAnswer
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            let questionModel = quizPlayer.examQuestions[quizPlayer.currentIndex]
            
            //MARK: Quiz Info Details View
            HStack(alignment: .center, spacing: 15) {
                /// Exam Icon Image
                Image("IconImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                VStack(alignment: .leading, spacing: 4) {
                    /// Short Name
                    Text("Practice Quiz")
                        .foregroundStyle(.black)
                        .opacity(0.6)
                    /// Long Name
                    Text("New York Bar Exam")
                        .font(.title3)
                        .foregroundStyle(.themePurple)
                        .fontWeight(.semibold)
                        .lineLimit(2, reservesSpace: true)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            //MARK: Quiz Visualizer
            /// Header
            HStack {
                Text("Question \(quizPlayer.currentIndex + 1)/\(quizPlayer.examQuestions.count)")
                    .font(.callout)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                /// Switch Visualizer
                Button {
                    hideText()
                } label: {
                    Image(systemName: "headphones")
                        .foregroundStyle(.themePurple)
                        .padding(12)
                        .background {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .environment(\.colorScheme, .light)
                        }
                }
            }
            
            //MARK: Question Content View
            Text("\(questionModel.questionContent)")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(!tester ? .black : .red)
                .lineLimit(6, reservesSpace: true)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            //MARK: Options Selection View
            VStack(spacing: 12) {
                ForEach(questionModel.options, id: \.self) { option in
                    optionButton(questionModel: questionModel, option: option)
                }
            }
            .padding(.vertical, 10)
            
            FullScreenControlView(
                isNowPlaying: isNowPlaying, quizPlayer: quizPlayer,
                
                repeatAction: {
                    
                    if let question = quizPlayer.currentQuestion {
                        quizPlayer.replayQuestion(question: question)
                    }
                },
                
                stopAction: {quizPlayer.endQuiz()},
                
                micAction: {
                    
                    quizPlayer.recordAnswer()
                },
                
                playAction: { isNowPlaying.toggle();  },
                
                nextAction: {
                    guard quizPlayer.currentIndex < quizPlayer.examQuestions.count - 1 else { return }
                    
                    quizPlayer.playNextQuestion()
                },
                endAction: { quizPlayer.endQuiz() })
            
            
            
            
        }
        //.background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(.clear))
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
//        .onAppear {
//            //speechManager.checkPermissions()
//        }
        
        
    }
    
    @ViewBuilder
    private func optionButton(questionModel: TestQuestionModel, option: String) -> some View {
        let optionColor = colorForOption(option: option, correctOption: questionModel.correctOption, userAnswer: "\(questionModel.selectedOption)")
        
        Button(action: {
            questionModel.selectedOption = option
            quizPlayer.saveAnswer(for: questionModel.id, answer: questionModel.selectedOption)
            tester.toggle()
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
    @StateObject var quizPlayer = QuizPlayer()
    let questions =  [TestQuestionModel(
        id: UUID(),
        questionContent: "Some random sample question 1",
        questionNote: "Sample data audio question answer in Mp3 format",
        topic: "Science",
        options: ["A", "B", "C", "D"],
        correctOption: "C",
        selectedOption: "",
        isAnswered: false,
        isAnsweredCorrectly: false,
        numberOfPresentations: 0,
        questionAudio: "Sample data audio question in Mp3",
        questionNoteAudio: "Sample data audio question answer in Mp3 format"),
                      
                      TestQuestionModel(
                        id: UUID(),
                        questionContent: "Some random sample question 2",
                        questionNote: "Sample data audio question answer in Mp3 format",
                        topic: "Science",
                        options: ["A", "B", "C", "D"],
                        correctOption: "C",
                        selectedOption: "",
                        isAnswered: false,
                        isAnsweredCorrectly: false,
                        numberOfPresentations: 0,
                        questionAudio: "Sample data audio question in Mp3",
                        questionNoteAudio: "Sample data audio question answer in Mp3 format"),
                      TestQuestionModel(
                        id: UUID(),
                        questionContent: "Some random sample question 3",
                        questionNote: "Sample data audio question answer in Mp3 format",
                        topic: "Science",
                        options: ["A", "B", "C", "D"],
                        correctOption: "C",
                        selectedOption: "",
                        isAnswered: false,
                        isAnsweredCorrectly: false,
                        numberOfPresentations: 0,
                        questionAudio: "Sample data audio question in Mp3",
                        questionNoteAudio: "Sample data audio question answer in Mp3 format")
                      
    ]
    return CustomQuestionDisplayView(quizPlayer: quizPlayer) {
        
    }
}
