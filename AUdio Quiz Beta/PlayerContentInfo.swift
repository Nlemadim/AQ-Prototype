//
//  PlayerContentInfo.swift
//  Exam Genius Audio Quiz Player
//
//  Created by Tony Nlemadim on 1/15/24.
//

import Foundation
import SwiftUI

struct PlayerContentInfo: View {
    @ObservedObject var quizPlayer: QuizPlayer
    var body: some View {
        HStack  {
            MiniPlayerControls(controlConfiguration: quizPlayer.controlConfiguration)
        }
        .foregroundStyle(.teal)
        .padding(.horizontal)
        .padding(.bottom, 12)
        .frame(height: 70)
        .contentShape(Rectangle())
    }
}

struct MiniPlayerControls: View {
    @State private var fillAmount: CGFloat = 0.0
    @State private var showProgressRing: Bool = false
    @State var controlConfiguration: QuizControlConfiguration
    let imageSize: CGFloat = 18
    
    var body: some View {
        HStack(spacing: 5) { // Adjust spacing as needed
                    Button(action: {
                        controlConfiguration.selectA()
                    }, label: {
                        Text("A")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                            .frame(width: 40, height: 25)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.teal))
                            .padding(.horizontal)
                    })
                    
                    Button(action: {
                        controlConfiguration.selectB()
                    }, label: {
                        Text("B")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                            .frame(width: 40, height: 25)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.teal))
                            .padding(.horizontal)
                    })
                   
                    // Repeat Button
                    Button(action: {
                        controlConfiguration.selectReplay()
                    }) {
                        Image(systemName: "backward.end.fill")
                            .font(.title3)
                            .foregroundStyle(.white)
                    }

                    // Play/Pause Button
                    Button(action: {
                        controlConfiguration.selectPlay()
                    }) {
                        Image(systemName: "play.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }

                    // Next Button
                    Button(action: {
                        controlConfiguration.selectNext()
                    }) {
                        Image(systemName: "forward.end.fill")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                    
                    Button(action: {
                        controlConfiguration.selectC()
                    }, label: {
                        Text("C")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                            .frame(width: 40, height: 25)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.teal))
                            .padding(.horizontal)
                    })
                    
                    Button(action: {
                        controlConfiguration.selectB()
                    }, label: {
                        Text("D")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                            .frame(width: 40, height: 25)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.teal))
                            .padding(.horizontal)
                    })
                }
        .frame(maxWidth: .infinity)
        .foregroundStyle(.teal)
    }
}

