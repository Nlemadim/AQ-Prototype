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
    @Published var audioQuizPlaylist: [DownloadedAudioQuiz]
    
    var currentPlayPosition: Int = 0
    
    init(audioQuizPackage: AudioQuizPackage? = nil) {
        self.audioQuizPackage = audioQuizPackage
        self.audioQuizPlaylist = []
    }
    
    var currentQuiz: DownloadedAudioQuiz? {
        !audioQuizPlaylist.isEmpty ? audioQuizPlaylist[currentPlayPosition] : nil
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
