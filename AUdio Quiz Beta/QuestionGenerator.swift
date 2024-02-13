//
//  QuestionGenerator.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/12/24.
//

import SwiftUI
import SwiftData

extension QuizBuilder {
    class QuestionGenerator {
        private let networkService: NetworkService = NetworkService.shared
        let builder: QuizBuilder
        var questioNumber: Int = 0
        
        init(builder: QuizBuilder) {
            self.builder = builder
        }
    }
}
