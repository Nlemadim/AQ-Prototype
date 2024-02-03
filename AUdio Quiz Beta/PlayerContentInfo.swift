//
//  PlayerContentInfo.swift
//  Exam Genius Audio Quiz Player
//
//  Created by Tony Nlemadim on 1/15/24.
//

import Foundation
import SwiftUI

struct PlayerContentInfo: View {
    @Binding var expandSheet: Bool
   // @Bindable var questions: [Question]
    @ObservedObject var quizPlayer: QuizPlayer
    var animation: Namespace.ID

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                if !expandSheet {
                    GeometryReader { geometry in
                        Image("IconImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipShape(RoundedRectangle(cornerRadius: expandSheet ? 15 : 5, style: .continuous))
                    }
                }
            }
            .frame(width: 45, height: 45)
            
            Text("New York Bar Exam")
                .font(.callout)
                //.fontWeight(.bold)
                .lineLimit(2, reservesSpace: true)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
//            Text("Sample Audio Quiz")
//                .font(.footnote)
//                .multilineTextAlignment(.leading)
//                .lineLimit(2, reservesSpace: true)
//                .frame(maxWidth: .infinity, alignment: .leading)

            MiniPlayerControls(
                recordAction: {quizPlayer.recordAnswer()},
                
                playPauseAction: { quizPlayer.startQuiz() },
                
                nextAction: { quizPlayer.skipToNext() },
                
                repeatAction: {
                    if let question = quizPlayer.currentQuestion {
                        quizPlayer.replayQuestion(question: question)
                    }
                }
            )
            .offset(x: 25)
             
        }
        .foregroundStyle(.teal)
        .padding(.horizontal)
        .padding(.bottom, 12)
        .frame(height: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                expandSheet = true
            }
        }
    }
}

//#Preview {
//    
//    let sample = FeaturedQuiz
//    let sampleQuiz = sample.driversLicense
//    @StateObject var quizPlayer = QuizPlayer(questions: sampleQuiz.questions)
//    return FullScreenControlView(isNowPlaying: true, quizPlayer: quizPlayer, showQuizControl: {})
//        .preferredColorScheme(.dark)
//}
//
//#Preview {
//    let sample = FeaturedQuiz
//    let sampleQuiz = sample.mcat
//    @StateObject var quizPlayer = QuizPlayer(questions: sampleQuiz.questions)
//    return MiniPlayerControls(recordAction: {}, playPauseAction: {}, nextAction: {}, repeatAction: {})
//        .preferredColorScheme(.dark)
//}

