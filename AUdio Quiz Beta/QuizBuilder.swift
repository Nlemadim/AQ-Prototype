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
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var userQuizPackage: AudioQuizPackage?
    var status: QuizBulderStatus =  .idle
    
    private func buildQuizTopics(quiz package: AudioQuizPackage) {
        status = .downloadingTopics
        let generator = TopicGenerator(builder: self)
        Task {
            await generator.buildAudioQuizTopics(package)
        }
        status = .idle
    }
    
    //MARK: TODO- Complete question generation method/api call
    //MARK: Each Topioc will Generate 10 questions
    private func generateQuizQuestions(_ topics: [Topic]) {
        status = .downloadingQuestions
        let generator = QuestionGenerator(builder: self)
        Task {
            // await generator.buildAudioQuizQuestions(package)
        }
        status = .idle
    }
    
    private func fetchQuestionsAudio(quiz package: DownloadedAudioQuiz) {
        status = .downloadingAudiofiles
        let generator = AudioGenerator(builder: self)
        Task {
            await generator.updateQuestionGroup()
        }
        modelContext.insert(package)
        try! modelContext.save()
        status = .idle
    }
    
    func fetchCollectionImages() {
        status = .downloadingImages
        let generator = ImageGenerator(builder: self)
        let quizNames = audioQuizCollection.map { $0.name }
        for name in quizNames {
            Task {
                await generator.fetchImages(for: name)
                
                //MARK: TODO: Query the audioQuizPakage by name, attach image, insert into modelContext, save.
            }
        }
        status = .idle
    }
    
    func selectQuizPackage(_ package: AudioQuizPackage) {
        self.userQuizPackage = package
        buildQuizTopics(quiz: package)
        generateQuizQuestions(package.topics)
    }
    
    func createDynamicAudioQuizzes(quiz: AudioQuizPackage) async {
        status = .creatingAudioQuiz
        let newAudioQuiz = DownloadedAudioQuiz(quizname: quiz.name, quizImage: quiz.imageUrl)
        fetchQuestionsAudio(quiz: newAudioQuiz)
        ///Business Logic
        ///STEP 1: Generate one question from randonmly topic and update presentation value and number of presentations
        ///STEP 2: Generate Audiofiles for each Question
        ///STEP 3 : Modify this method to call itself provided continuityCollection is less than 3 elements
        ///STEP 4 : Add logic to ensure that Topic from which question will be generated has not been presented before
        ///STEP 5: Add new quiz to database as DownloadedAudioQuiz
        
        
        status = .idle
    }
    
    func registerPerformance(audio quiz: DownloadedAudioQuiz) {
        //MARK: TODO - Link to User has Ended Quiz to create a performance History
    }
}

enum QuizBulderStatus {
    case idle
    case downloadingImages
    case downloadingTopics
    case downloadingQuestions
    case downloadingAudiofiles
    case creatingAudioQuiz
    case error
    
    var message: String {
        switch self {
        case .downloadingImages:
            "Downloading Images"
        case .downloadingTopics:
            "Getting Topics"
        case .downloadingQuestions:
            "Building Questions"
        case .creatingAudioQuiz:
            "Creating Playlist"
        case .error:
            "Error Fetching Data"
        case .idle:
            ""
        case .downloadingAudiofiles:
            "Downloading Audio files"
        }
    }
}

