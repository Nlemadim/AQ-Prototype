//
//  QuizPlayer.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/22/24.
//

import Foundation
import SwiftUI
import SwiftData
import AVFoundation
import Speech

class TestQuestionModel: ObservableObject, Identifiable {
    var id: UUID
    var questionContent: String
    var questionNote: String
    var topic: String
    var options: [String]
    var correctOption: String
    @Published var selectedOption: String = ""
    var isAnswered: Bool = false
    var isAnsweredCorrectly: Bool
    var numberOfPresentations: Int
    var questionAudio: String
    var questionNoteAudio: String
    
    init(id: UUID, questionContent: String, questionNote: String, topic: String, options: [String], correctOption: String, selectedOption: String, isAnswered: Bool, isAnsweredCorrectly: Bool, numberOfPresentations: Int, questionAudio: String, questionNoteAudio: String) {
        self.id = id
        self.questionContent = questionContent
        self.questionNote = questionNote
        self.topic = topic
        self.options = options
        self.correctOption = correctOption
        self.selectedOption = selectedOption
        self.isAnswered = isAnswered
        self.isAnsweredCorrectly = isAnsweredCorrectly
        self.numberOfPresentations = numberOfPresentations
        self.questionAudio = questionAudio
        self.questionNoteAudio = questionNoteAudio
    }
    
}


class QuizPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate, SFSpeechRecognizerDelegate {
    @Published var progress: CGFloat = 0
    @Published var score: CGFloat = 0
    @Published var currentIndex: Int = 0
    
    @Published var examQuestions: [TestQuestionModel] = [
        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 1", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 1: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
        
        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 2", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 2: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
        
        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 3", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 3: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
        
        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 4", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 4: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
        
        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 4", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 5: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format")]
    
    
//    @State var currentQuestions: [TestQuestionModel] = [
//        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 1", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 1 sample audi data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
//        
//        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 2", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 2 sample audi data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
//        
//        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 3", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 3 sample audi data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
//        
//        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 4", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 4 sample audi data", questionNoteAudio: "Sample data audio question answer in Mp3 format")
//    ]
//    
    @State private var speechSynthesizer = AVSpeechSynthesizer()

    var isQuizStarted: Bool = false
    var showScoreCard: Bool = false
    var announceScoreCard: Bool = false
 
    
    private var playlist: [TestQuestionModel] = []
   
    

    
    func startQuiz() {
        isQuizStarted = true
        progress = 0
        score = 0
        currentIndex = 0
        let question = examQuestions[currentIndex]
        //playAudio(audioFileName: question.questionAudio)
    }
    
    func playNextQuestion() {
        if currentIndex < examQuestions.count - 1 {
            currentIndex += 1
            let question = examQuestions[currentIndex]
            //playAudio(audioFileName: question.questionAudio)
            progress = CGFloat(currentIndex) / CGFloat(examQuestions.count)
        } else {
            endQuiz()
        }
    }
    
    func playAudio(audioFileName: String) {
//        let fileManager = FileManager.default
//        let url = URL(fileURLWithPath: audioFileName)
//        
//        // Check if the file exists before trying to play it
//        if fileManager.fileExists(atPath: url.path) {
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: url)
//                audioPlayer?.play()
//            } catch {
//                print("Error playing audio file: \(error)")
//            }
//        } else {
//            print("Audio file not found at path: \(audioFileName)")
//        }
        
        //TESTING
        readQuestionContent(questionContent: audioFileName)
    }
    

    
    var currentQuestion: TestQuestionModel? {
        guard currentIndex < examQuestions.count else { return nil }
        return examQuestions[currentIndex]
    }
    
    var calculatedScore: CGFloat {
        return score / CGFloat(examQuestions.count) * 100
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
        }
        
        //MARK: Recording and Updating Total Questions Answered
        UserDefaultsManager.incrementTotalQuestionsAnswered()
        UserDefaultsManager.updateNumberOfTopicsCovered()
    }
    
    private func resetForNextQuiz() {
        progress = 0
        // Consider whether you want to reset the score here
        
        currentIndex = 0
    }
    
    func endQuiz() {
        // End the quiz and calculate the final score
        
        // Update the state to reflect the quiz has ended
        
        showScoreCard = true
        
        resetForNextQuiz()
        
    }
    
    enum AnswerOption: String {
        case a = "A"
        case b = "B"
        case c = "C"
        case d = "D"
        
        var index: Int {
            switch self {
            case .a:
                return 0
            case .b:
                return 1
            case .c:
                return 2
            case .d:
                return 3
            }
        }
    }
    
    //UI TESTING
    func readQuestionContent(questionContent: String) {
        let utterance = AVSpeechUtterance(string: questionContent)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // You can change the language here
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate // You can adjust the speech rate
        
        speechSynthesizer.speak(utterance)
        
        print(utterance)
    }
}









//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Question.self, configurations: config)
//        let example = Question(id: UUID(), questionContent: "Some random sample question", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Sample data audio question in Mp3", questionNoteAudio: "Sample data audio question answer in Mp3 format")
//        let playList = Array(repeating: example, count: 5)
//        let player = QuizPlayer(playlist: playList)
//        return QuizPlayerControls(quizPlayer: player, question: example)
//
//    } catch {
//
//        return Text("Failed to create Preview: \(error.localizedDescription)")
//    }
