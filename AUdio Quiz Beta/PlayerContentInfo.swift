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
        .frame(height: 70)
        .contentShape(Rectangle())
    }
}


