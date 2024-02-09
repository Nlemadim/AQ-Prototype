//
//  QuizPlayerExtensions.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/26/24.
//

import Foundation
import AVFoundation
import SwiftUI

extension QuizPlayer {
    
    var controlConfiguration: QuizControlConfiguration {
        return QuizControlConfiguration(
            selectA: { self.selectedOption = self.currentQuestion?.options[0] ?? ""},
            selectB: { self.selectedOption = self.currentQuestion?.options[1] ?? ""},
            selectC: { self.selectedOption = self.currentQuestion?.options[2] ?? "" },
            selectD: { self.selectedOption = self.currentQuestion?.options[3] ?? ""},
            selectPlay: { self.startQuiz() },
            selectReplay: {
                if let question = self.currentQuestion {
                    self.replayQuestion(question: question)
                }
            },
            selectNext: { self.skipToNext() })
    }
    
    var questionCounter: String {
        return "Question \(currentIndex + 1)/\(examQuestions.count)"
    }
    
    func startQuiz() {
        isQuizStarted = true
        print("Quiz has started")
        if let question = currentQuestion {
            playNow(audioFileName: question.questionAudio)
        }
    }
    
    func skipToNext() {
        audioPlayer?.stop()
        guard let currentQuestion = currentQuestion,
              currentIndex < examQuestions.count - 1 else {
            endQuiz()
            return
        }
        currentIndex += 1
        playNow(audioFileName: currentQuestion.questionAudio)
    }
    
    func playNextQuestion() {
        guard let currentQuestion = currentQuestion,
              currentIndex < examQuestions.count - 1 else {
            isNowPlaying = false
            
            endQuiz()
            return
        }
        
        isFinishedPlaying = false
        currentIndex += 1
        playNow(audioFileName: currentQuestion.questionAudio)
    }
    
    func replayQuestion(question: Question) {
        playNow(audioFileName: question.questionAudio)
    }
    
    func completeQuiz() {
        let score = calculatedScore
        //let newSession = Performance(id: UUID(), date: Date(), score: CGFloat(score))
        //databaseService.savePerformance(id: newSession.id, date: newSession.date, score: newSession.score)
        
        UserDefaultsManager.incrementNumberOfTestsTaken()
        UserDefaultsManager.updateHighScore(Int(score))
        UserDefaultsManager.incrementNumberOfQuizSessions() // Incrementing the number of quiz
    }
    
    func saveAnswer(for questionId: UUID, answer: String) {
        if let index = examQuestions.firstIndex(where: { $0.id == questionId }) {
            examQuestions[index].selectedOption = answer
            // UpdatScore
        }
        //databaseService.updateQuestion(id: questionId)
        
        //MARK: Recording and Updating Total Questions Answered
        UserDefaultsManager.incrementTotalQuestionsAnswered()
        //UserDefaultsManager.updateNumberOfTopicsCovered()
    }
    
    var calculatedScore: CGFloat {
        return score / CGFloat(examQuestions.count) * 100
    }
    
    func resetForNextQuiz() {
        
        progress = 0
        currentIndex = 0
        
        //databaseService.fetchMoreQuestions()
    }
    
    func endQuiz() {
        isQuizStarted = false
        //If !intermissionPlayList.isEmpty { playIntermission() } else { resetForNextQuiz() }
        
        
        // End the quiz and calculate the final score
        // Update the state to reflect the quiz has ended
        showScoreCard = true
        resetForNextQuiz()
    }
    
}
