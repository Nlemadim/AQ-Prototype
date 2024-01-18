//
//  ScoreCardView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import Foundation
import SwiftUI

struct ScoreCardView: View {
    @Environment(\.dismiss) private var dismiss
    var score: CGFloat
    var onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color("QuizMain")
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 15) {
                    Text("Congratulations!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    VStack(spacing: 15) {
                        Text("You Scored")
                            .font(.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        Text(String(format: "%.0f", score) + "%")
                            .font(.title.bold())
                            .padding(.bottom, 10)
                        
                        Image(systemName: "trophy.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color("OrangeDark"))
                            .font(.system(size: 150, weight: .bold))
                            .frame(height: 150)
                            .padding()

                        // Stars
                        HStack(spacing: 25) {
                            ForEach(0..<5) { index in
                                Image(systemName: "star.fill")
                                    .foregroundColor(score > CGFloat(index) * 20.0 ? .yellow : .gray)
                                    .scaleEffect(2)
                            }
                        }
                        .padding(.top, 10)
                    }
                    .foregroundStyle(.black)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                    .hAlign(.center)
                    .background {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(Color("QuizMain"))
                    }
                }
                .vAlign(.center)
                
                CustomButton(title: "Back to Home") {
                    dismiss()
                    onDismiss()
                }
                .padding(15)
                .vAlign(.bottom)
                .padding(.bottom, 50)
            }
        }
    }
}
