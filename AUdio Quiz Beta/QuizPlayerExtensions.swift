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
    
    func startQuiz() {
        isQuizStarted = true
        progress = 0
        score = 0
        currentIndex = 0
        let question = examQuestions[currentIndex]
        playAudio(audioFileName: question.questionAudio)
    }
    
    func playNextQuestion() {
        if currentIndex < examQuestions.count - 1 {
            currentIndex += 1
            let question = examQuestions[currentIndex]
            playAudio(audioFileName: question.questionAudio)
            progress = CGFloat(currentIndex) / CGFloat(examQuestions.count)
        } else {
            endQuiz()
        }
    }
    
    
    func completeQuiz() {
        let score = calculatedScore
        //let newSession = Performance(id: UUID(), date: Date(), score: CGFloat(score))
        //databaseService.savePerformance(id: newSession.id, date: newSession.date, score: newSession.score)
        
        UserDefaultsManager.incrementNumberOfTestsTaken()
        UserDefaultsManager.updateHighScore(Int(score))
        UserDefaultsManager.incrementNumberOfQuizSessions() // Incrementing the number of quiz
    }
    
    func recordAnswer(for questionId: UUID, answer: String) {
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
        // End the quiz and calculate the final score
        
        // Update the state to reflect the quiz has ended
        
        showScoreCard = true
        
        resetForNextQuiz()
        
    }
}


extension QuizPlayer {
    
    var questionProgressCounter: String { "Question \(currentIndex + 1)/\(examQuestions.count)"}
    
    var interactionStatus: String { interactionState.status }
    
}



extension QuizPlayer {
    
    // Method for synced playing of audio, transcribing response, and handling quiz flow
    func syncedPlay() {
        startQuiz()
        readAndTranscribeCurrentQuestion()
    }
    
    func playAudio(audioFileName: String) {
        let fileManager = FileManager.default
        let url = URL(fileURLWithPath: audioFileName)
        
        // Check if the file exists before trying to play it
        if fileManager.fileExists(atPath: url.path) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.delegate = self
                audioPlayer?.play()
            } catch {
                print("Error playing audio file: \(error)")
            }
        } else {
            print("Audio file not found at path: \(audioFileName)")
        }
        
        //TESTING
        // readQuestionContent(questionContent: audioFileName)
    }
    
    // Method to play a specific audio file immediately
    func playNow(audioFileName: String) {
        // Add the audio file to the top of the playlist
        addToPlaylistTop(audioFileName: audioFileName)
        
        // Start playing the audio file
        playAudio(audioFileName: audioFileName)
    }
    
    func replayQuestion(question: TestQuestionModel) {
        playAudio(audioFileName: question.questionAudio)
    }
    
    
    
    func recordAnswer() {
        // Start recording
        isRecordingAnswer = true
        startRecording()
        
        // Wait for 5-7 seconds
        let recordingDuration = Double.random(in: 5...7)
        DispatchQueue.main.asyncAfter(deadline: .now() + recordingDuration) {
            // Stop recording
            self.stopRecording()
            
            // Transcribe the recorded answer
            self.transcribeRecordedAnswer()
            
            // Update the state
            self.isRecordingAnswer = false
            
            self.getTranscript { newTranscript in
                self.currentQuestion?.selectedOption = newTranscript
            }
        }
    }
    
    // Method to add an audio file to the playlist
    func addToPlaylist(audioFileName: String) {
        if !playlist.contains(audioFileName) {
            playlist.append(audioFileName)
        }
    }
    
    // Method to remove an audio file from the playlist by its name
    func removeFromPlaylist(audioFileName: String) {
        playlist.removeAll { $0 == audioFileName }
    }
    
    // Method to remove an audio file from the playlist by its index
    func removeFromPlaylist(at index: Int) {
        guard playlist.indices.contains(index) else { return }
        playlist.remove(at: index)
    }
    
    
    
    // Helper method to add an audio file to the top of the playlist
    private func addToPlaylistTop(audioFileName: String) {
        // Remove the audio file if it already exists in the playlist to avoid duplication
        removeFromPlaylist(audioFileName: audioFileName)
        
        // Insert the audio file at the beginning of the playlist
        playlist.insert(audioFileName, at: 0)
    }
    
    
    private func startRecording() {
        guard !isRecordingAnswer != false else { return }
        startRecordingAndTranscribing()
    }
    
    private func stopRecording() {
        guard isRecordingAnswer == true else { return }
        speechRecognizer.stopTranscribing()
        self.getTranscript { newTranscript in
            self.currentQuestion?.selectedOption = newTranscript
        }
    }
    
    private func transcribeRecordedAnswer() {
        // Implement the logic to transcribe the recorded audio
        self.speechRecognizer.transcribe()
    }
    
    private func readAndTranscribeCurrentQuestion() {
        guard let question = currentQuestion else { return }
        
        // Read out the question
        readQuestionContent(questionContent: question.questionContent)
        
        // Wait for the audio file to finish playing
        playAudio(audioFileName: question.questionAudio)
        
        // Call the following after the audio has finished
        DispatchQueue.main.asyncAfter(deadline: .now() + durationOf(question.questionAudio)) {
            self.startRecordingAndTranscribing()
        }
    }
    
    private func startRecordingAndTranscribing() {
        self.isRecordingAnswer = true
        // Wait for 5-7 seconds for transcribed answer
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.speechRecognizer.transcribe()
        }
        
        // After transcribing, stop transcription and turn off recording
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.speechRecognizer.stopTranscribing()
            self.isRecordingAnswer.toggle()
            
            // Logic to check if the answer is captured and proceed accordingly
            if let currentQuestion = self.currentQuestion, !currentQuestion.selectedOption.isEmpty {
                self.currentIndex += 1
            } else {
                //quizPlayer.pauseQuiz()
                
            }
        }
    }
    
    // Helper method to estimate the duration of audio file playing
    private func durationOf(_ audioFileName: String) -> Double {
        // Implement logic to determine the duration of the audio file
        // This could be a static duration or dynamically calculated based on the audio file
        return 10 // Example static duration
    }
    
    
    
}

