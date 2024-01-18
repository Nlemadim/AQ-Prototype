//
//  QuestionView.swift
//  ExamGenius
//
//  Created by Tony Nlemadim on 12/13/23.
//

import SwiftUI
import SwiftData

struct QuestionView: View {
    @Binding var isQuizStarted: Bool
    @State private var showScoreCard: Bool = false
    @Query var questions: [Question]
    var onDismiss: () -> Void
    var examType: String = ""
    
    var body: some View {
        VStack(spacing: 15) {
            Text(examType)
                .font(.title2)
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            QuestionDisplayView(questions: questions, currentIndex: 0)
                .padding(.horizontal, -15)
                .padding(.vertical, 15)
            
            NextQuestionButton(
                currentIndex: 0,
                totalQuestions: 0,
                action: {}, endQuizAction: {
                    
                }
                //endQuizAction: viewModel.endQuiz // Assuming you have implemented endQuiz method in your ViewModel
            )
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("QuizMain").ignoresSafeArea())
        .fullScreenCover(isPresented: $showScoreCard) {
            ScoreCardView(score: 0, onDismiss: {
                isQuizStarted = false
                showScoreCard = false
            })
        }
    }
    
    @ViewBuilder
    func QuestionDisplayView(questions: [Question], currentIndex: Int) -> some View {
        if questions.isEmpty {
            ContentUnavailableView(
                "Questions Unavailable",
                image: "list.bullet.rectangle.portrait.fill",
                description: Text("Please ensure you have selected a Test")
                    .foregroundStyle(.black)
            ).foregroundStyle(.black)
            
        } else {
            if questions.indices.contains(currentIndex) {
                let currentQuestion = questions[currentIndex]
                let options = currentQuestion.options
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Question \(currentIndex + 1)/\(questions.count)")
                        .font(.callout)
                        .foregroundStyle(.black.opacity(currentQuestion.selectedOption == currentQuestion.correctOption ? 1 : 0.7))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(currentQuestion.questionContent)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
//                    VStack(spacing: 12) {
//                        ForEach(options, id: \.self) { index in
//                            let option = options[index]
//                            let isCorrect = option.value == currentQuestion.correctOption
//                            
//                            let optionColor = colorForOption(option: option, correctOption: currentQuestion.correctOption, userAnswer: currentQuestion.userAnswer)
//                            
//                            OptionsView(option: option, tint: optionColor, isCorrect: isCorrect, explanation: "Explanation for \(option)", action: {
//                                if currentQuestion.userAnswer.isEmpty {
//                                    //viewModel.recordAnswer(questionId: currentQuestion.id, answer: option)
//                                }
//                            })
//                        }
//                    }
//                    .padding(.vertical, 10)
                }
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color("OrangeLight")))
                .padding(.horizontal, 15)
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
    
    // Function to record an answer for a question
    //MARK TODO: Add a Property to record Correct and Wrong answer records
    
//    func recordAnswer(for questionId: UUID, answer: String) {
//        if let index = currentQuestions.firstIndex(where: { $0.id == questionId }) {
//            currentQuestions[index].userAnswer = answer
//        }
//        
//        //MARK: Recording and Updating Total Questions Answered
//        UserDefaultsManager.incrementTotalQuestionsAnswered()
//        UserDefaultsManager.updateNumberOfTopicsCovered()
//    }
    
    func completeQuiz() {
//        let score = calculateScore()
//        let newSession = Performance(id: UUID(), date: Date(), score: CGFloat(score))
//        
//        
//        databaseService.savePerformance(id: newSession.id, date: newSession.date, score: newSession.score)
//        
//        UserDefaultsManager.incrementNumberOfTestsTaken()
//        UserDefaultsManager.updateHighScore(score)
//        UserDefaultsManager.incrementNumberOfQuizSessions() // Incrementing the number of quiz
    }

    // Private methods
//    private func calculateScore() -> Int {
//        return currentQuestions.reduce(0) { score, question in
//            score + (question.userAnswer == question.correctOption ? 1 : 0)
//        }
//    }
}

//struct ProgressBarView: View {
//    var progress: CGFloat
//    
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .leading) {
//                Rectangle()
//                    .fill(Color.black.opacity(0.2))
//                
//                Rectangle()
//                    .fill(Color("OrangeDark"))
//                    .frame(width: progress * geometry.size.width)
//            }
//            .clipShape(Capsule())
//        }
//    }
//}

struct NextQuestionButton: View {
    var currentIndex: Int
    var totalQuestions: Int
    var action: () -> Void
    var endQuizAction: () -> Void
    
    var body: some View {
        CustomButton(title: currentIndex == totalQuestions - 1 ? "Finish" : "Next Question") {
            if currentIndex == totalQuestions - 1 {
                endQuizAction() // Call endQuiz when the last question is reached
            } else {
                action()
            }
        }
    }
}

#Preview {
    ContentView()
}
