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
    @Published var selectedQuiz: AudioQuiz? {
        didSet {
            Task {
                await TestQuestionAudioGenerator.shared.updateQuestionGroup(questions: selectedQuiz?.questions ?? [])
            }
        }
    }

    init(selectedQuiz: AudioQuiz? = nil) {
        self.selectedQuiz = selectedQuiz
        
    }
}

struct AudioQuiz: Quiz {
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
