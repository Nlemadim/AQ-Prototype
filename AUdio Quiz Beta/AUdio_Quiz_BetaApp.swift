//
//  AUdio_Quiz_BetaApp.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import SwiftUI
import SwiftData

@main
struct AUdio_Quiz_BetaApp: App {
    @StateObject var quizPlayer = QuizPlayer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(quizPlayer)
        }
        .modelContainer(for: [ExamType.self, Topic.self])
    }
}
