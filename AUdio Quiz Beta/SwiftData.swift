//
//  SwiftData.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Question: Hashable {
    @Attribute(.unique) var questionContent: String
    var questionNote: String
    var topic: String
    var options: [String]
    var correctOption: String
    var selectedOption: String = ""
    var isAnswered: Bool = false
    var isAnsweredCorrectly: Bool
    var numberOfPresentations: Int
    var questionAudio: String
    var questionNoteAudio: String
    
    init(questionContent: String, questionNote: String, topic: String, options: [String], correctOption: String, selectedOption: String, isAnswered: Bool, isAnsweredCorrectly: Bool, numberOfPresentations: Int, questionAudio: String, questionNoteAudio: String) {
        self.questionContent = questionContent
        self.questionNote = questionNote
        self.topic = topic
        self.options = options
        self.correctOption = correctOption
        self.selectedOption = selectedOption
        self.isAnswered = isAnswered
        self.isAnsweredCorrectly = isAnsweredCorrectly
        self.numberOfPresentations = numberOfPresentations
        self.questionAudio = questionAudio
        self.questionNoteAudio = questionNoteAudio
    }
}

@Model
class ExamType: ObservableObject {
    var id: PersistentIdentifier
    var name: String
    var about: String
    var imageUrl: String
    var category: String
    
    init(id: PersistentIdentifier, name: String, about: String, imageUrl: String, category: String) {
        self.id = id
        self.name = name
        self.about = about
        self.imageUrl = imageUrl
        self.category = category
    }
}

@Model
class Topic {
    @Attribute(.unique) var name: String
    var generalOverview: String
    var audioNote: String
    var isPresented: Bool = false
    var inFocus: Bool = false
    
    init(name: String, generalOverview: String, audioNote: String, isPresented: Bool, inFocus: Bool) {
        self.name = name
        self.generalOverview = generalOverview
        self.audioNote = audioNote
        self.isPresented = isPresented
        self.inFocus = inFocus
    }
}

@Model
class AudioPlayerItem {
    @Attribute(.unique) var name: String
    var audioNote: String
    var image: String
    
    init(name: String, audioNote: String, image: String) {
        self.name = name
        self.audioNote = audioNote
        self.image = image
    }
}

@Model
class AudioQuiz: ObservableObject {
    @Attribute(.unique) var testName: String
    var image: String
    var topics: [String]
    var questions: [Question]
    
    init(testName: String, image: String, topics: [String], questions: [Question], currentQuestions: [Question]) {
        self.testName = testName
        self.image = image
        self.topics = topics
        self.questions = questions
        self.currentQuestions = currentQuestions
    }
    
    @Relationship
    var currentQuestions: [Question] = []
}

@Model
class Performance: Identifiable, Hashable {
    let id: UUID
    var date: Date
    var score: CGFloat
    
    init(id: UUID, date: Date, score: CGFloat) {
        self.id = id
        self.date = date
        self.score = score
    }
}
