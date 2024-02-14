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


class QuizPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate, SFSpeechRecognizerDelegate {
    
    @Published var progress: CGFloat = 0
    @Published var score: CGFloat = 0
    @Published var currentIndex: Int = 0
    @Published var userTranscript: String = ""
    @Published var playlist: [String: String] = [:]
    @Published var isFinishedPlaying: Bool = false
    @Published var isRecordingAnswer: Bool = false
    @Published var isNowPlaying: Bool = false
    @Published var selectedOption: String = ""
    
    @State var interactionState: InteractionState = .idle
    @State var playerState: PlayerState = .idle
    @State var isUingMic: Bool = false
       
    private var speechRecognizer = SpeechManager()
    private let user: User
    private var speechSynthesizer = AVSpeechSynthesizer()
    var audioPlayer: AVAudioPlayer?

    var currentPlaybackQueue: [String] = []
    var cancellable: AnyCancellable?
    var showScoreCard: Bool = false
    var announceScoreCard: Bool = false
    var completionHandler: (() -> Void)?
    
    var examQuestions: [Question] {
        return user.currentQuiz?.contents ?? []
    }
    
    var currentQuestion: Question? {
        guard currentIndex < examQuestions.count else { return nil }
        
        return examQuestions[currentIndex]
    }
    
    init(user: User) {
        self.user = user
        self.isUingMic = user.isUsingMic
        super.init()
    }
    
    func quizPlayerDidFinishPlaying(completion: @escaping (Bool) -> Void) {
        self.cancellable = Future<Bool, Never> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                promise(.success(true))
            }
        }
        .receive(on: DispatchQueue.main)
        .sink { [weak self] finished in
            self?.isFinishedPlaying = finished
            completion(finished)
        }
    }
    
    // Method to play a specific audio file immediately
    func playNow(audioFileName: String) {
        playerState = .isPlayingQuestion
        // Start playing the audio file
        playAudio(audioFileName: audioFileName)

        if let currentQuestion {
            print("Player Started playing Question\(currentIndex + 1): \(isNowPlaying)")
            print("Player Finished playing: \(isFinishedPlaying)")
            print("User chose Option \(currentQuestion.selectedOption)")
            print("The correct Answer is \(currentQuestion.correctOption)")
            print("Player Started playing: \(isNowPlaying)")
        }
    }
    
    fileprivate func playAudio(audioFileName: String) {
        //guard isFinishedPlaying else { return }
        isNowPlaying = true
        isFinishedPlaying = false
        
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
        //readQuestionContent(questionContent: audioFileName)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Player has Finished playing")
        isFinishedPlaying = true
        playerState = .isAwaitingAnswer
        //startRecordingAndTranscribing()
     }
    
    fileprivate func checkSelectedOptionAndUpdateState() {
            if UserDefaultsManager.isOnContinuousFlow() /* && !selectedOption.isEmpty */{
                // Proceed to the next audio file
                print("Playing next Question")
                playNextQuestion()
            } else {
                // Wait for user interaction to proceed
                //interactionState = .awaitingResponse
                audioPlayer?.stop()
                playerState = .isPaused
                print("Player paused while awaiting response")
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
    
    //MARK: Recording Methods
    func recordAnswer() {
        startRecordingAndTranscribing()
    }
    
    fileprivate func startRecordingAndTranscribing() {
        guard playerState == .isAwaitingAnswer else { return }

        print("Starting transcription...")
        interactionState = .isListening
        self.isRecordingAnswer = true

        // Immediately start transcribing
        self.speechRecognizer.transcribe()
        print("Transcribing started")

        // Schedule to stop transcribing after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.speechRecognizer.stopTranscribing()
            self.isRecordingAnswer = false
            print("Transcription stopped")
            
            // Optionally, retrieve and process the transcript after stopping
            self.getTranscript { newTranscript in
                self.interactionState = .isProcessing
                self.currentQuestion?.selectedOption = self.processTranscript(transcript: newTranscript)
                print("Processing completed")

                // Further processing or state update can be done here
                self.checkSelectedOptionAndUpdateState()
            }
        }
    }
    

    fileprivate func getTranscript(completion: @escaping (String) -> Void) {
        cancellable = speechRecognizer.$transcript
            .sink { newTranscript in
                completion(newTranscript)
            }
    }
    
    func processTranscript(transcript: String) -> String {
        let processedTranscript = WordProcessor.processWords(from: transcript)
        self.selectedOption = processedTranscript
        if processedTranscript.isEmptyOrWhiteSpace {
            playerState = .failureTranscribingAnswer
            //MARK: TODO
            //playErrorTranscriptionSound()
        } else {
            playerState = .successTranscribingAnswer
            //MARK: TODO
            //playSuccessFulTranscriptionSound()
        }
        return processedTranscript
    }

    deinit {
        cancellable?.cancel()
    }
}


/* fileprivate func startRecordingAndTranscribing() {
 self.isRecordingAnswer = true
 // Wait for 5-7 seconds for transcribed answer
 DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
     self.speechRecognizer.transcribe()
 }
 
 // After transcribing, stop transcription and turn off recording
 DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
     self.speechRecognizer.stopTranscribing()
     self.isRecordingAnswer.toggle()
 }
}

func getTranscript(completion: @escaping (String) -> Void) {
 cancellable = speechRecognizer.$transcript
     .sink { newTranscript in
         completion(newTranscript)
         self.currentQuestion?.selectedOption = newTranscript
     }
}*/





//    @Published var examQuestions: [TestQuestionModel] = [
//        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 1", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 1: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
//
//        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 2", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 2: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
//
//        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 3", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 3: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
//
//        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 4", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 4: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format"),
//
//        TestQuestionModel(id: UUID(), questionContent: "Some random sample question 4", questionNote: "Sample data audio question answer in Mp3 format", topic: "Science", options: ["A", "B", "C", "D"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "Question 5: Sample audio question data", questionNoteAudio: "Sample data audio question answer in Mp3 format")]
//


//TESTING
//        quizPlayerDidFinishPlaying(completion: { finished in
//            if finished {
//                self.isNowPlaying = false
//                self.playNextQuestion()
//            }
//        })


class TestQuestionModel: ObservableObject, Identifiable {
    var id: UUID
    var questionContent: String
    var questionNote: String
    var topic: String
    var options: [String]
    var correctOption: String
    var selectedOption: String = ""
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

class TestTopicModel: ObservableObject, Identifiable {
    @Attribute(.unique) var name: String
    var generalOverview: String
    var audioNote: String
    var isPresented: Bool = false
    var inFocus: Bool = false
    
    init(name: String, generalOverview: String, audioNote: String, isPresented: Bool, inFocus: Bool) {
        self.name = name
        self.generalOverview = generalOverview
        self.audioNote = audioNote
        self.isPresented = isPresented
        self.inFocus = inFocus
    }
}
