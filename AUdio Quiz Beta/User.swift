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
    @Published var userAnswer: String = ""
    @Published var useMic: Bool = false
    @Published var selectedQuiz: UserSelectedQuiz? {
        didSet {
            Task {
                await TestQuestionAudioGenerator.shared.updateQuestionGroup(questions: selectedQuiz?.questions ?? [])
            }
        }
    }
    
    var questionLimit: Int = 0
    var questionsAnswered: Int = 0
    var questionsFailed: Int = 0
    var questionsPassed: Int = 0

    init(selectedQuiz: UserSelectedQuiz? = nil) {
        self.selectedQuiz = selectedQuiz
        
    }
}

struct UserSelectedQuiz: Quiz {
    var quizName: String
    var quizImage: Image
    var questions: [Question]
    
    init(from featuredQuiz: FeaturedQuiz) {
        self.quizName = featuredQuiz.quizName
        self.quizImage = featuredQuiz.quizImage
        self.questions = featuredQuiz.questions
    }
}




protocol Quiz {
    var quizName: String { get }
    var quizImage: Image { get }
    var questions: [Question] { get }
}
