//
//  ImageGeneration.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/9/24.
//

import Foundation

extension NetworkService {
    
    // Fetch images for a list of quiz names asynchronously, using retries
    func fetchImages(for quizNames: [String]) async -> [String: String?] {
        var images: [String: String?] = [:]
        
        await withTaskGroup(of: (String, String?).self) { group in
            for quizName in quizNames {
                group.addTask {
                    let imageUrl = await self.attemptFetchImage(for: quizName, retries: 3)
                    return (quizName, imageUrl)
                }
            }
            
            for await (quizName, imageUrl) in group {
                images[quizName] = imageUrl
            }
        }
        
        return images
    }
    
    // Attempt to fetch an image for a given quiz name, with retries
    private func attemptFetchImage(for quizName: String, retries: Int) async -> String? {
        for attempt in 0..<retries {
            do {
                let imageUrl = try await fetchImage(for: quizName)
                return imageUrl
            } catch {
                print("Attempt \(attempt + 1) failed for quiz \(quizName): \(error)")
                if attempt == retries - 1 {
                    return nil // Return nil if all retries fail
                }
                // Optionally, add a delay before retrying
            }
        }
        return nil // This line is redundant but makes the control flow clear
    }
    
    // Fetch image for a single quiz name
    private func fetchImage(for quizName: String) async throws -> String {
        var components = URLComponents(string: Config.imageRequestURL)
        components?.queryItems = [URLQueryItem(name: "quizName", value: quizName)]
        
        guard let apiURL = components?.url else {
            throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])
        }
        
        guard httpResponse.statusCode == 200 else {
            // Use httpResponse directly within the guard condition
            throw NSError(domain: "NetworkService", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch image with status code \(httpResponse.statusCode)"])
        }
        
        // Assuming the response is a base64-encoded image string
        guard let imageB64 = String(data: data, encoding: .utf8) else {
            throw NSError(domain: "NetworkService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
        }
        
        return imageB64
    }

    
}