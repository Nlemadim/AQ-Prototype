//
//  QuizBuilder.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/12/24.
//

import SwiftUI
import SwiftData
import Combine

final class QuizBuilder: ObservableObject {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \AudioQuizPackage.name) var audioQuizCollection: [AudioQuizPackage]
    @Query(sort: \AudioQuizPackage.name) var userSelectedQuiz: AudioQuizPackage

    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    private var continuityCollection: [AudioQuiz] = []
    
    var userQuizPackage: AudioQuizPackage? {
        guard let package = user.audioQuizPackage else {
            return nil
        }
        
        return package
    }
    
    private func buildQuizTopics(quiz package: AudioQuizPackage) {
        let generator = TopicGenerator(builder: self)
        Task {
            await generator.buildAudioQuizTopics(package)
        }
    }
    
    //MARK: TODO- Complete question generation method/api call
    private func generateQuizQuestions() {
        
    }
    
    private func fetchQuestionsAudio(quiz package: [AudioQuizPackage]) {
        let generator = AudioGenerator(builder: self)
        Task {
            await generator.updateQuestionGroup()
        }
    }
    
    private func fetchCollectionImages() {
        let generator = ImageGenerator(builder: self)
        var quizNames = audioQuizCollection.map { $0.name }
        for name in quizNames {
            Task {
                await generator.fetchImages(for: name)
                
                //MARK: TODO: Query the audioQuizPakage by name, attach image, insert into modelContext, save.
            }
        }
    }
    
    func createDynamicAudioQuizzes()  {
        ///Business Logic
        ///STEP 1: Generate one question from randonmly topic and update presentation value and number of presentations
        ///STEP 2: Generate Audiofiles for each Question
        ///STEP 3 : Modify this method to call itself provided continuityCollection is less than 3 elements
        ///STEP 4 : Add logic to ensure that Topic from which question will be generated has not been presented before
        ///STEP 5: Add new quiz to database as DownloadedAudioQuiz
    }
  
}

