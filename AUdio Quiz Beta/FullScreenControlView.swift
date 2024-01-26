//
//  FullScreenControlView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/25/24.
//

import SwiftUI

struct FullScreenControlView: View {
    @State var isNowPlaying: Bool
    var repeatAction: () -> Void
    var stopAction: () -> Void
    var micAction: () -> Void
    var playAction: () -> Void
    var nextAction: () -> Void
    var endAction: () -> Void

    var body: some View {
        HStack(spacing: 30) {
            // Repeat Button
            Button(action: repeatAction) {
                Image(systemName: "memories")
                    .font(.title)
                    .foregroundColor(.themePurple)
                    
            }

            // Stop Button
            Button(action: stopAction) {
                Image(systemName: "stop.fill")
                    .font(.title)
                    .foregroundColor(.themePurple)
                   
            }

            // Mic Button with Progress Ring
            MicButtonWithProgressRing(action: {
                
            })

            // Play/Pause Button
            Button(action: {
                isNowPlaying.toggle()
            }) {
                Image(systemName: isNowPlaying ?  "play.fill" : "pause.fill")
                    .font(.title)
                    .foregroundColor(.themePurple)
                    
            }

            // Next/End Button
            Button(action: nextAction) {
                Image(systemName: "forward.end.fill")
                    .font(.title)
                    .foregroundColor(.themePurple)
                    
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100) // Adjust as needed
    }
}

struct MicButtonWithProgressRing: View {
    @State private var fillAmount: CGFloat = 0.0
    @State private var showProgressRing: Bool = false
    let action: () -> Void

    let imageSize: CGFloat = 25 // Adjusted size

    var body: some View {
        ZStack {
            // Background
            Circle()
                .fill(Color.themePurple)
                .frame(width: imageSize * 3, height: imageSize * 3)

            // Conditional display of Progress Ring
            if showProgressRing {
                Circle()
                    .stroke(Color.white.opacity(0.3), lineWidth: 5)
                    .frame(width: imageSize * 3, height: imageSize * 3)

                Circle()
                    .trim(from: 0, to: fillAmount)
                    .stroke(Color.red, lineWidth: 8)
                    .frame(width: imageSize * 3, height: imageSize * 3)
                    .rotationEffect(.degrees(-180))
                    .animation(.linear(duration: 5), value: fillAmount)
            }

            // Mic Button
            Button(action: {
                self.action()
                self.startFilling()
            }) {
                Image(systemName: "mic.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }

    private func startFilling() {
        fillAmount = 0.0 // Reset the fill amount
        showProgressRing = true // Show the progress ring
        withAnimation(.linear(duration: 5)) {
            fillAmount = 1.0 // Fill the ring over 5 seconds
        }
        // Hide the progress ring after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showProgressRing = false
        }
    }
}

#Preview {
    FullScreenControlView()
}
