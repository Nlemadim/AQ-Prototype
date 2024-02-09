//
//  AudioQuizCollectionVM.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/9/24.
//

import Foundation
import SwiftUI
import SwiftData

struct AudioQuizCollectionVM {
    @Environment(\.modelContext) private var modelContext
    @State private var path = [AudioQuizPackage]()
    @Query(sort: \AudioQuizPackage.name) var audioQuizCollection: [AudioQuizPackage]
    private let networkService: NetworkService = NetworkService.shared
    
    func createAudioQuizCollection() async {
        let defaultCollection = DefaultAudioQuizCollection.allCases
        
        defaultCollection.forEach { quizName in
            let newAudioQuiz = AudioQuizPackage(id: UUID(), name: quizName.rawValue)
            modelContext.insert(newAudioQuiz)
            try! modelContext.save()
        }
    }
}
