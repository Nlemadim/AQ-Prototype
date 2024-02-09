//
//  MiniPlayerControls.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/31/24.
//

import SwiftUI

struct QuizControlConfiguration {
    let selectA: () -> Void
    let selectB: () -> Void
    let selectC: () -> Void
    let selectD: () -> Void
    let selectPlay: () -> Void
    let selectReplay: () -> Void
    let selectNext: () -> Void
}


struct MiniPlayerControls: View {
    @State private var fillAmount: CGFloat = 0.0
    @State private var showProgressRing: Bool = false
    var controlConfiguration: QuizControlConfiguration
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
            
            Spacer(minLength: 0)
            
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
            
            Spacer(minLength: 0)
            
            StartButton()
            
            Spacer(minLength: 0)

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
            
            Spacer(minLength: 0)
            
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
#Preview {
   StartButton()
        .preferredColorScheme(.dark)
}



struct StartButton: View {
    @State private var isFilling = false
    @State private var progress: CGFloat = 0.0
    let fillUpDuration = 5.0

    var body: some View {
        Button(action: {
            // Toggle filling state
            isFilling.toggle()
            
            if isFilling {
                // Start the animation to fill the progress ring
                withAnimation(.linear(duration: fillUpDuration)) {
                    progress = 1.0
                }
                // Schedule the reset after the fillUpDuration
                DispatchQueue.main.asyncAfter(deadline: .now() + fillUpDuration) {
                    isFilling = false // Reset filling state
                    progress = 0.0 // Reset progress
                }
            }
        }) {
            ZStack {
                Circle()
                    .strokeBorder(Color.gray.opacity(0.5), lineWidth: 4)
                    .frame(width: 46, height: 46)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.orange, style: StrokeStyle(lineWidth: 4, lineCap: .round)).activeGlow(.orange, radius: 1)
                    .rotationEffect(.degrees(-270))
                    .frame(width: 45, height: 45)
                    .shadow(color: .orange, radius: 20)

                Image(systemName: isFilling ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(width: 45, height: 45)
            }
            
        }
    }
}

