//
//  Helpers.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import Foundation
import SwiftUI
import Speech

struct VisualEffectView: UIViewRepresentable {
    let effect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        return UIVisualEffectView(effect: effect)
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}

enum WordProcessor: String {
    case A, B, C, D

    static func processWords(from transcript: String) -> String {
        let lowercasedTranscript = transcript.lowercased()

        switch lowercasedTranscript {
        case "a", "eh", "ay", "hey", "ea", "hay", "aye":
            return WordProcessor.A.rawValue
        case "b", "be", "bee", "beat", "de", "bead":
            return WordProcessor.B.rawValue
        case "c", "see", "sea", "si", "cee", "seed":
            return WordProcessor.C.rawValue
        case "d", "dee", "the", "di", "dey", "they":
            return WordProcessor.D.rawValue
        default:
            return "" // or return a default value or handle the error
        }
    }
}

enum InteractionState {
    case isNowPlaying
    case isListening
    case isSpeaking
    case hasSpoken
    case idle
    
    var status: String {
        switch self {
        case .isNowPlaying:
            return "Now Playing"
        case .isListening:
            return "Listening"
        case .isSpeaking:
            return ""
        case .hasSpoken:
            return "Recieved Answer"
        case .idle:
            return "Start"
        }
    }
}


struct MessageDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.plainText] }
    var message: String
    init(message: String) {
        self.message = message
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        message = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: message.data(using: .utf8)!)
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
