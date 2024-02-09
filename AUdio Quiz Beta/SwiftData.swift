//
//  SwiftData.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import Foundation
import SwiftUI
import SwiftData

//@Model
@Model
final class ExamType {
    @Attribute(.unique) var name: String
    var about: String
    var imageUrl: String
    var category: String
    
    init(name: String, about: String, imageUrl: String, category: String) {
        self.name = name
        self.about = about
        self.imageUrl = imageUrl
        self.category = category
    }
}

@Model
class Topic {
    @Attribute(.unique) var name: String
    var isPresented: Bool
    var numberOfPresentations: Int
    
    init(name: String) {
        self.name = name
        self.isPresented = false
        self.numberOfPresentations = 0
    }
}

class Question: ObservableObject, Identifiable {
    var id: UUID
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
    
    init(id: UUID, questionContent: String, questionNote: String, topic: String, options: [String], correctOption: String, selectedOption: String, isAnswered: Bool, isAnsweredCorrectly: Bool, numberOfPresentations: Int, questionAudio: String, questionNoteAudio: String) {
        self.id = id
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

//@Model
//final class QuizPackage {
//    @Attribute(.unique) var quiz: ExamType
//    var topics: [Topic]
//    var questions: [Question]
//    
//    init(quiz: ExamType, topics: [Topic], questions: [Question]) {
//        self.quiz = quiz
//        self.topics = topics
//        self.questions = questions
//    }
//}

//@Model
//class AudioQuizDataModel {
//    var id: PersistentIdentifier
//    var quizName: ExamType
//    var quizmage: String
//    var topics: [Topic]
//    var questions: [Question]
//    
//    init(id: PersistentIdentifier, quizName: ExamType, quizmage: String) {
//        self.id = id
//        self.quizName = quizName
//        self.quizmage = quizmage
//        self.topics = []
//        self.questions = []
//    }
//}

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
