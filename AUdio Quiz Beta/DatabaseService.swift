//
//  DatabaseService.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import Foundation
import SwiftUI
import SwiftData

class DatabaseService {
    @Environment(\.modelContext) private var modelContext
    private let serialQueue = DispatchQueue(label: "com.examGenius.DatabaseService")
    //@Query var questions: [Question]
    @Query var topics: [Topic]
    @Query var exams: [AudioQuizPackage]
    
    
    let networkService = NetworkService.shared
    
    func mockApiCall() async {
        let questionContent = "Who is Liana? Option A: Keeks. Option B: Nkechinyere. Option C: My Daughter. Option D: The girl."
        _ = ["Paris", "Chad", "Madrid", "Rome"]
        
        do {
            let audioData = try await networkService.fetchAudioData(content: questionContent)
            _ = saveAudioDataToFile(audioData)
            
            _ = Question(id: UUID(), questionContent: "", questionNote: "", topic: "", options: [], correctOption: "", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")
            //modelContext.insert(question)
        } catch {
            print("Error fetching audio data:", error)
        }
    }
    
    func saveAudioDataToFile(_ data: Data) -> URL {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".mp3" // or appropriate file extension
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving audio file:", error)
            return fileURL // or handle the error appropriately
        }
    }
    
    /** Auto-delete method **/
    private func autoDeletePerformances() async throws {
        let performances = try await fetchPerformances()
        guard performances.count > 7 else { return }
        
        for performance in performances.prefix(performances.count - 7) {
            try deletePerformance(performance: performance)
        }
    }
    
    /** Delete method **/
    func deletePerformance(performance: Performance) throws {
        modelContext.delete(performance)
        try modelContext.save()
    }
    
//    func deleteQuestions() async throws {
//        let questions = try await fetchAllQuestions()
//        guard questions.count > 25 else { return }
//        
//        for question in questions.prefix(questions.count - 49) {
//            modelContext.delete(question)
//            try modelContext.save()
//        }
//    }
    
    func fetchPerformances() async throws -> [Performance] {
        return try await withCheckedThrowingContinuation { continuation in
            serialQueue.async {
                let fetchDescriptor = FetchDescriptor<Performance>()
                do {
                    let performances = try self.modelContext.fetch(fetchDescriptor)
                    continuation.resume(returning: performances)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
//    func fetchAllQuestions() async throws -> [Question] {
//        return try await withCheckedThrowingContinuation { continuation in
//            serialQueue.async {
//                let fetchDescriptor = FetchDescriptor<Question>()
//                do {
//                    let questions = try self.modelContext.fetch(fetchDescriptor)
//                    
//                    continuation.resume(returning: questions)
//                } catch {
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
}
