//
//  QuizPlayer.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/22/24.
//

import Foundation
import SwiftUI
import Combine
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
    @Published var userTranscript: String = ""
    
    @State private var speechSynthesizer = AVSpeechSynthesizer()
    @State var audioPlayer: AVAudioPlayer?
    @StateObject var speechRecognizer = SpeechManager()
    @State var interactionState: InteractionState = .idle
    
    @State var isQuizStarted: Bool = false
    @State var isRecordingAnswer: Bool = false
    @State var isPaused: Bool = false
    
    @Published var examQuestions: [TestQuestionModel] = [
        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 1", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 1: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
        
        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 2", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 2: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
        
        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 3", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 3: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
        
        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 4", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 4: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
        
        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 4", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 5: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format")]
    
    @Published var playlist: [String] = []
    
    var cancellable: AnyCancellable?
    var showScoreCard: Bool = false
    var announceScoreCard: Bool = false
    
    var currentQuestion: TestQuestionModel? {
        guard currentIndex < examQuestions.count else { return nil }
        return examQuestions[currentIndex]
    }
    
    //UI TESTING
    func readQuestionContent(questionContent: String) {
        let utterance = AVSpeechUtterance(string: questionContent)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // You can change the language here
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate // You can adjust the speech rate
        
        speechSynthesizer.speak(utterance)
        
        print(utterance)
    }
    
    func getTranscript(completion: @escaping (String) -> Void) {
        cancellable = speechRecognizer.$transcript
            .sink { newTranscript in
                completion(newTranscript)
                self.currentQuestion?.selectedOption = newTranscript
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
}







