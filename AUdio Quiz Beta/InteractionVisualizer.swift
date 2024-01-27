//
//  InteractionVisualizer.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/26/24.
//

import SwiftUI

struct InteractionVisualizer: View {
    @State var comment: String
    @State var correctOption: String
    @State var interactionState: InteractionState
    var quizPlayer: QuizPlayer

    var body: some View {
        let didRecieveSpeech = !comment.isEmpty
        let isPlaying = interactionState == .isNowPlaying || interactionState == .isListening

        VStack(spacing: 0) {
            HStack(spacing: 35) {
                HStack(spacing: 0) {
                    Button(action: {
                        
                    }, label: {
                       Image(systemName: "play.desktopcomputer")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(!isPlaying ? .black.opacity(0.6)  : .teal)
                    })

                    Image(systemName: "waveform")
                        .resizable()
                        .foregroundStyle(isPlaying ? .themeTeal : .black.opacity(0.6) )
                        .symbolEffect(.variableColor.iterative.dimInactiveLayers.reversing, options: .repeating, isActive: interactionState == .isNowPlaying)
                        .frame(width: 23, height: 23)
                        .offset(y: -5)
                        .padding(.leading, 3)
                        .activeGlow(isPlaying ? .themeTeal : .clear, radius: 2)
                }
                
                Spacer()

                Text(interactionState.status)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.themePurple)
                    .padding()
                
                Spacer()

                HStack(spacing: 0) {
                    ZStack {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .foregroundStyle(!didRecieveSpeech ? .black.opacity(0.6) : .black)
                            .symbolEffect(.scale.wholeSymbol, options: .nonRepeating, isActive: interactionState == .hasSpoken)
                            .frame(width: 23, height: 23)
                            .offset(y: -5)
                            .padding(.leading, 3)

                        Text(comment.isSingleCharacterABCD ? comment : "A")
                            .font(.caption)
                            .fontWeight(.bold)
                            .offset(y: -8)
                            .foregroundStyle(.themePurple)
                    }

                    Button(action: {
                        
                    }, label: {
                       Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(!didRecieveSpeech ? .black.opacity(0.6)  : .green)
                    })
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .frame(maxWidth: .infinity)

            // Quiz Progress Indicator
            ZStack {
                Capsule()
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .light)
                    .frame(height: 8)
                
                    //.padding(.top, 10)

                Capsule()
                    .fill(.themePurpleLight)
                    .frame(width: quizPlayer.progress, height: 8)
                    //.padding(.top, 10)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)

            // Question Number View
            HStack {
                Spacer()
                Spacer()
                Text("Question \(quizPlayer.currentIndex + 1)/\(quizPlayer.examQuestions.count)")
                    .font(.caption)
                    .foregroundStyle(.themePurple)
            }
            .padding(.top, 3)
            .padding(.horizontal)
        }
        //.frame(maxWidth: .infinity)
    }
}

struct NavBarInteractionVisualizer: View {
    @State var comment: String
    @State var correctOption: String
    @State var interactionState: InteractionState
    var quizPlayer: QuizPlayer

    var body: some View {
        let didRecieveSpeech = !comment.isEmpty
        let isPlaying = interactionState == .isNowPlaying || interactionState == .isListening

        VStack(spacing: 0) {
            HStack(spacing: 35) {
                HStack(spacing: 0) {
                       Image(systemName: "play.desktopcomputer")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(!isPlaying ? .black.opacity(0.6)  : .teal)
                    

                    Image(systemName: "waveform")
                        .resizable()
                        .foregroundStyle(isPlaying ? .themeTeal : .black.opacity(0.6) )
                        .symbolEffect(.variableColor.iterative.dimInactiveLayers.reversing, options: .repeating, isActive: interactionState == .isNowPlaying)
                        .frame(width: 23, height: 23)
                        .offset(y: -5)
                        .padding(.leading, 3)
                        .activeGlow(isPlaying ? .themeTeal : .clear, radius: 2)
                }
                .opacity(interactionState == .isNowPlaying ? 0 : 1)//UI TESTING! Please Switch before Run
                


                HStack(spacing: 0) {
                    ZStack {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .foregroundStyle(!didRecieveSpeech ? .black.opacity(0.6) : .black)
                            .symbolEffect(.scale.wholeSymbol, options: .nonRepeating, isActive: interactionState == .hasSpoken)
                            .frame(width: 23, height: 23)
                            .offset(y: -5)
                            .padding(.leading, 3)

                        Text(comment.isSingleCharacterABCD ? comment : "")
                            .font(.caption)
                            .fontWeight(.bold)
                            .offset(y: -8)
                            .foregroundStyle(.themePurple)
                    }

                    Button(action: {
                        
                    }, label: {
                       Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundStyle(!didRecieveSpeech ? .black.opacity(0.6)  : .green)
                            
                    })
                }
                .opacity(interactionState == .isSpeaking ? 0 : 1)//UI TESTING! Please Switch before Run
            }
            .padding(.horizontal)
            .padding(.top)
            .frame(width: 180)
        }
        //.frame(maxWidth: .infinity)
    }
}




#Preview {
    @StateObject var quizPlayer = QuizPlayer()
    return InteractionVisualizer(comment: "", correctOption: "", interactionState: .idle, quizPlayer: quizPlayer)
}

#Preview {
    @StateObject var quizPlayer = QuizPlayer()
    return NavBarInteractionVisualizer(comment: "", correctOption: "", interactionState: .idle, quizPlayer: quizPlayer)
}
