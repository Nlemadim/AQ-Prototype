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
    @Query var questions: [Question]
    @Query var topics: [Topic]
    @Query var exams: [ExamType]
    @Query var audioQuiz: [AudioQuiz]
    @Query var audioPlayerItems: [AudioPlayerItem]
    
    
    
    let networkService = NetworkService.shared
    
    func mockApiCall() async {
        let questionContent = "Who is Liana? Option A: Keeks. Option B: Nkechinyere. Option C: My Daughter. Option D: The girl."
        let options = ["Paris", "Chad", "Madrid", "Rome"]

        do {
            let audioData = try await networkService.fetchAudioData(content: questionContent)
            let fileURL = saveAudioDataToFile(audioData)

            
            let question = Question(topic: "Geography",
                                    questionContent: questionContent,
                                    options: options,
                                    correctOption: "Paris",
                                    selectedOption: "",
                                    isAnswered: false,
                                    isAnsweredCorrectly: false,
                                    numberOfPresentations: 0,
                                    questionAudio: fileURL.path,
                                    moreAboutCorrectOption: "Paris is the capital and most populous city of France.")
        
            // Insert or update the question in your model context
            modelContext.insert(question)
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
}
