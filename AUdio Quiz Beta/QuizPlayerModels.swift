//
//  QuizPlayerModels.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/20/24.
//

import Foundation

struct QuestionModel {
    var question: String
    var options: [String]
    var questionAudioFile: String
    var selectedOption: String
    var correctOption: String
}
