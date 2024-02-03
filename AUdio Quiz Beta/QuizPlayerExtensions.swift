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


extension QuizPlayer {
    
    // Play the next audio in the queue
    func playNext() {
        guard !currentPlaybackQueue.isEmpty else { return }
        
        if interactionState == .idle || UserDefaultsManager.isOnContinuousFlow() {
            let nextAudio = currentPlaybackQueue.removeFirst()
            currentIndex += 1
            print("Player has moved to the next question")
            playNow(audioFileName: nextAudio)
            interactionState = .isNowPlaying
        } else {
            // Wait for user response or completion of recording/transcription
        }
    }
    
    //MARK: Playlist Methods
    // Populate playlist with questions and corresponding topic notes
    func populatePlaylist(with questions: [TestQuestionModel], topics: [TestTopicModel]) {
        playlist = questions.reduce(into: [String: String]()) { dict, question in
            let topicAudio = topics.first { $0.name == question.topic }?.audioNote ?? ""
            dict[question.questionAudio] = topicAudio
        }
        setupPlaybackQueue()
    }
    
    // Set up the playback queue based on user settings
    private func setupPlaybackQueue() {
        currentPlaybackQueue = Array(playlist.keys)
        
        //TODO: Modify to continue after questions are exhausted and there are topic notes
        if UserDefaultsManager.isOnContinuousFlow() {
            // If continuous flow, play questions first, then topics
            currentPlaybackQueue.append(contentsOf: playlist.values)
        }
    }
}


//TEST METHODS
extension QuizPlayer {
    func testRecording() {
            // Turn on isRecordingAnswer after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isRecordingAnswer = true

                // Then turn it off after an additional 5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.isRecordingAnswer = false
                }
            }
        }
    
}

// Helper method to find a question based on its audio file
//    private func findQuestion(fromAudio audio: String) -> TestQuestionModel? {
//        currentIndex += 1
//        if let currentQuestion = currentQuestion {
//            return currentQuestion
//        }
//
//        return nil
//    }
//

// Method to add an audio file to the playlist
//    func addToPlaylist(audioFileName: String) {
//        if !playlist.contains(audioFileName) {
//            playlist.append(audioFileName)
//        }
//    }

// Method to remove an audio file from the playlist by its name
//    func removeFromPlaylist(audioFileName: String) {
//        playlist.removeAll { $0 == audioFileName }
//    }
//
// Method to remove an audio file from the playlist by its index
//    func removeFromPlaylist(at index: Int) {
//        guard playlist.indices.contains(index) else { return }
//        playlist.remove(at: index)
//    }

// Helper method to add an audio file to the top of the playlist
//    private func addToPlaylistTop(audioFileName: String) {
//        // Remove the audio file if it already exists in the playlist to avoid duplication
//        removeFromPlaylist(audioFileName: audioFileName)
//
//        // Insert the audio file at the beginning of the playlist
//        playlist.insert(audioFileName, at: 0)
//    }


extension QuizPlayer {
//    class QuizIntermission: ObservableObject {
//        var quizPlayer: QuizPlayer = QuizPlayer.self
//        @Published var intermissionPlaylist: [String] = []
//        
//        func fetchIntermissionQuizReview(question: String, topic: String) -> String {
//
//            let incorrectQuestions = quizPlayer.examQuestions.filter { $0.isAnswered && !$0.isAnsweredCorrectly && $0.topic == topic }
//            
//            for question in incorrectQuestions {
//               //let topicAudioNote = topicsService.fetchTopicAudioNote(topic name: question.topic)
//                let audioNote = question.questionNoteAudio
//                //questionService.fetchQuestionAudioNote(question: question.questionAudioNote)
//                
//                intermissionPlaylist.append(audioNote)
//                //intermissionPlaylist.append(topicNote)
//            }
//                
//            return ""
//        }
//        
//        func fetchIntermissionTopicReview(topic: String) -> String {
//            // let auidioNote = topicsService.fetchTopicAudioNote(topic name: )
//            // intermissionPlaylist.append(audioNote)
//            
//            return ""
//        }
//    }
}
