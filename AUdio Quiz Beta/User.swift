//
//  User.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/2/24.
//

import Foundation
import SwiftUI

final class User: ObservableObject {
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var isUsingMic: Bool = false
    @Published var audioQuizPackage: AudioQuizPackage?
    @Published var audioQuiz: DownloadedAudioQuiz? { didSet { Task {}}}


    init(selectedQuiz: DownloadedAudioQuiz? = nil, audioQuizPackage: AudioQuizPackage? = nil) {
        self.audioQuiz = selectedQuiz
        self.audioQuizPackage = audioQuizPackage
    }
}

struct AudioQuiz {
    var quizName: String
    var quizImage: String
    var questions: [Question]
    
//    init(from featuredQuiz: FeaturedQuiz) {
//        self.quizName = featuredQuiz.quizName
//        self.quizImage = featuredQuiz.quizImage
//        self.questions = featuredQuiz.questions
//    }
}



protocol Quiz {
    var quizName: String { get }
    var quizImage: Image { get }
    var questions: [Question] { get }
}
