//
//  AudioGenerator.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/12/24.
//

import SwiftUI
import SwiftData

extension QuizBuilder {
    class AudioGenerator {
        private let networkService: NetworkService = NetworkService.shared
        let builder: QuizBuilder
        var questioNumber: Int = 0

        init(builder: QuizBuilder) {
            self.builder = builder
        }
        
        func updateQuestionGroup() async {
            guard let package = builder.userQuizPackage, !package.questions.isEmpty else { return }
            
            for question in package.questions {
                questioNumber += 1
                await self.generateAudioQuestion(question: question)
                //print("Error generating audio for question: \(question.questionContent)")
            }
            
            builder.modelContext.insert(package)
            try! builder.modelContext.save()
        }
        
        private func generateAudioQuestion(question: Question) async {
            let readOut = formatQuestionForReadOut(questionContent: question.questionContent, options: question.options)
            
            do {
                let audioFile = try await networkService.fetchAudioData(content: readOut)
                let fileUrl = saveAudioDataToFile(audioFile)
                updateQuestionAudioContent(question: question, audioFilePath: fileUrl.path)
                
            } catch {
                print(error.localizedDescription) //MARK: TODO: Modify for retry
            }
        }
        
        private func updateQuestionAudioContent(question: Question, audioFilePath: String) {
            question.questionAudio = audioFilePath
        }
        
        private func saveAudioDataToFile(_ data: Data) -> URL {
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
        
        private func formatQuestionForReadOut(questionContent: String, options: [String]) -> String {
            return """
                   Question:\(questioNumber)
                   
                   \(questionContent)
                   
                   Options:
                   
                   Option A: \(options[0])
                   Option B: \(options[1])
                   Option C: \(options[2])
                   Option D: \(options[3])
                   
                   """
        }
    }
}
