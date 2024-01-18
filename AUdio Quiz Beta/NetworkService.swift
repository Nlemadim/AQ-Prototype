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
        var components = URLComponents(string: "https://ljnsun.buildship.run/testAudioGeneration")
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
    
    

    
}
