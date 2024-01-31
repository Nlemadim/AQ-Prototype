//
//  ContentView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
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
}
