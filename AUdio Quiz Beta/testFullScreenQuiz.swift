//
//  testFullScreenQuiz.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/30/24.
//

import SwiftUI

struct testFullScreenQuiz: View {
    @ObservedObject var quizPlayer: QuizPlayer
    @State var isAnswered: Bool = false
    var body: some View {
        ZStack {
            if let questionModel = quizPlayer.currentQuestion {
                VStack(spacing: 8) {
                    QuizInfoDetailsView()
                        .frame(alignment: .topLeading)
                    HStack {
                        Text(quizPlayer.questionCounter)
                            .font(.callout)
                            .foregroundStyle(.black)
                            //.frame(maxWidth: .infinity, alignment: .topLeading)
                        Spacer()
                    }
                    
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
                        OptionButton(questionModel: questionModel, option: option, quizPlayer: quizPlayer, buttonAction: {
                            
                        })
                    }
                    
                    FullScreenControlView(isNowPlaying: true, quizPlayer: quizPlayer, showQuizControl: {})
                  
                }
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            
        }
        //.preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
//        .background(
//            Image("Logo")
//                .blur(radius: 50)
//                //.offset(x:  220, y: -100)
//            
//        )
    }
    
    private func updateView() {
        isAnswered.toggle()
    }
}

//#Preview {
//    let sample = FeaturedQuiz
//    let sampleQuiz = sample.barExam
//    @StateObject var quizPlayer = QuizPlayer(questions: sampleQuiz.questions)
//    return testFullScreenQuiz(quizPlayer: quizPlayer)
//}
