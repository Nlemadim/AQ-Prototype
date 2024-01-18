//
//  DebugLogger.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import Foundation
import SwiftData

class DebugLogger {
    private func debugPrintQuestions(_ questions: [Question]) {
        // Print details of the first few questions for debugging
        for question in questions.prefix(5) {
            print("Question: \(question.questionContent)")
            print("Options: \(question.options)")
            print("IsAnswered: \(question.isAnswered)")
            print("User Answered: \(question.selectedOption)")
            print("User is correct: \(question.isAnsweredCorrectly)")
            print("Correct Option: \(question.correctOption)")
            print("QuestionNote: \(question.questionNote)")
            print("Topic: \(question.topic)")
            // Add any other fields you want to check
        }
    }
}
