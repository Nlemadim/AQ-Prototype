//
//  AudioQuizCollectionVM.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/9/24.
//

import Foundation
import SwiftUI
import SwiftData

class AudioQuizCollectionVM: ObservableObject {
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
    
    func fetchAndUpdateImagesForQuizzes() async {
        // Assuming you have a way to obtain the quiz names from `audioQuizCollection`
        let quizNames = audioQuizCollection.map { $0.name }
        
        // Fetch images for these quizzes
        let imageMappings = await networkService.fetchImages(for: quizNames)
        
        // Update the quizzes with their corresponding images
        for quiz in audioQuizCollection {
            if let imageUrl = imageMappings[quiz.name] {
                // Perform the update on the main thread
                    quiz.imageUrl = imageUrl ?? ""
                    //self.modelContext.insert(quiz)
                    // Save the updated quiz object to your model context as necessary
            }
        }
    }
}
