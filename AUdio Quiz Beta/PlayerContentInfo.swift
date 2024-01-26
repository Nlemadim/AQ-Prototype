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

            MiniQuizControlView(
                recordAction: { /* Implement record action */ },
                playPauseAction: { /* Implement play/pause action */ },
                nextAction: { /* Implement next action */ },
                repeatAction: { /* Implement repeat action */ }
            )
            .offset(x: 25)
            //Spacer()
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

#Preview {
    FullScreenControlView(isNowPlaying: true, repeatAction: {}, stopAction: {}, micAction: {}, playAction: {}, nextAction: {}, endAction: {})
        .preferredColorScheme(.dark)
}

#Preview {
    MiniQuizControlView(recordAction: {}, playPauseAction: {}, nextAction: {}, repeatAction: {})
        .preferredColorScheme(.dark)
}

