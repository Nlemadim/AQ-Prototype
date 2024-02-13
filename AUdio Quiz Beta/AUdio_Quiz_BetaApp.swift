//
//  AUdio_Quiz_BetaApp.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import SwiftUI
import SwiftData

@main
struct Audio_Quiz_BetaApp: App {
    @StateObject var user = User()
    @StateObject var quizPlayer = QuizPlayer(user: User())
    @StateObject var quizBuilder = QuizBuilder(user: User())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
                .environmentObject(quizPlayer)
                .environmentObject(quizBuilder)
        }
        .modelContainer(for: [AudioQuizPackage.self, Topic.self, Question.self, Performance.self])
    }
}

