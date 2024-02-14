//
//  ContentView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var quizPlayer: QuizPlayer
    var body: some View {
        HomeView()
     
    }
}

#Preview {
    let user = User()
    let quizPlayer = QuizPlayer(user: user)
    return ContentView()
        .environmentObject(user)
        .environmentObject(quizPlayer)
        .modelContainer(for: [AudioQuizPackage.self], inMemory: true)
}
