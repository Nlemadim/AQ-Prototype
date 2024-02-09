//
//  NetworkService.swift
//  SwiftDataComponent
//
//  Created by Tony Nlemadim on 1/12/24.
//

import Foundation
import SwiftUI
import AVFoundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchAudioData(content: String) async throws -> Data {
        // Construct the URL with query parameters for the API call
        var components = URLComponents(string: Config.audioRequestURL)
        components?.queryItems = [
            URLQueryItem(name: "content", value: content)
        ]
        
        guard let apiURL = components?.url else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Fetch the response from your API
        let (data, response) = try await URLSession.shared.data(for: request)
                
        // Check the HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse, userInfo: ["Description": "Invalid HTTP response"])
        }
        
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse, userInfo: ["Description": "Server returned status code \(httpResponse.statusCode)"])
        }
        
        // Decode the base64 string to Data
        guard let decodedData = Data(base64Encoded: data) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response data"])
        }
        
        return decodedData
    }
    
    func fetchTopics(context: String) async throws -> [String] {
         //Base URL
        let baseUrl = "https://ljnsun.buildship.run/"

        // Append query parameter
        guard var urlComponents = URLComponents(string: baseUrl) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        urlComponents.queryItems = [URLQueryItem(name: "context", value: context)]

        // Check if URL is valid
        guard let url = urlComponents.url else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to construct URL"])
        }

        // Create a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // URLSession data task
        let (data, response) = try await URLSession.shared.data(for: request)

        // Log the raw server response
        if let httpResponse = response as? HTTPURLResponse, let rawResponse = String(data: data, encoding: .utf8) {
            print("Response HTTP Status code: \(httpResponse.statusCode)")
            print("Raw server response: \(rawResponse)")
        }

        // Decode JSON
        let jsonResponse = try JSONDecoder().decode([String: [String]].self, from: data)
        guard let topics = jsonResponse["topics"] else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Key 'topics' not found in response"])
        }

        return topics
    }
    
    //MARK: ENTRY POINT
    func fetchSampleAudioQuiz()  async throws {}
}

