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
   // @EnvironmentObject var quizPlayer: QuizPlayer
    var body: some View {
        @ObservedObject var quizPlayer = QuizPlayer()
        return HomeView(quizPlayer: quizPlayer)
        
        //MARK: UI VIEWS TEST VIEW
        //Test()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [ExamType.self, Topic.self], inMemory: true)
}
