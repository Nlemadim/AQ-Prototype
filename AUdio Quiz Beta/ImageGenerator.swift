//
//  ImageGenerator.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/12/24.
//

import Foundation
import SwiftUI
import SwiftData


extension QuizBuilder {
    class ImageGenerator {
        var quizPackage: [AudioQuizPackage]
        private let networkService: NetworkService = NetworkService.shared
        let builder: QuizBuilder
        
        init(builder: QuizBuilder) {
            self.builder = builder
            self.quizPackage = builder.audioQuizCollection
        }
        
        func fetchImages(for quizName: String) async {
            do {
                let imageB64 = await networkService.fetchImage(for: quizName)
                
                if let data = imageB64 {
                    guard let imageData = Data(base64Encoded: data) else {
                        throw NSError(domain: "Base64DecodingError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode base64 string"])
                    }
                    
                    if let fileUrl = saveImageToDocuments(data: imageData) {
                        // Find the quiz object and update its imageUrl
                        if let index = quizPackage.firstIndex(where: { $0.name == quizName }) {
                            quizPackage[index].imageUrl = fileUrl.absoluteString
                        }
                    } else {
                        throw NSError(domain: "ImageSavingError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Failed to save image"])
                    }
                }
            } catch {
                print("Error fetching image for \(quizName): \(error.localizedDescription)")
                // Handle error (e.g., show an error message to the user)
            }
        }
        
        func saveImageToDocuments(data: Data) -> URL? {
            let fileManager = FileManager.default
            if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileName = UUID().uuidString + ".png" // Unique name for the file
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                do {
                    try data.write(to: fileURL)
                    return fileURL
                } catch {
                    print("Error saving image: \(error.localizedDescription)")
                    return nil
                }
            }
            return nil
        }
        
    }
}
