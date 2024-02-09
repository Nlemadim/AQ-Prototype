//
//  ImageGeneration.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/9/24.
//

import Foundation

extension NetworkService {
    
    func fetchImage(for quizNames: [String], completion: @escaping (String?, Error?) -> Void) {
        let group = DispatchGroup()
        
        quizNames.forEach { quizName in
            group.enter()
            attemptFetchImage(for: quizName, retries: 3) { imageUrl, error in
                DispatchQueue.main.async {
                    completion(imageUrl, error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("Completed all image fetches.")
        }
    }
    
    private func attemptFetchImage(for quizName: String, retries: Int, completion: @escaping (String?, Error?) -> Void) {
        let requestBody = [
            "apiKey": "YOUR_API_KEY",
            "model": "text-davinci-003",
            "input": quizName,
            "size": "1024x1024"
        ]
        
        guard let url = URL(string: Config.imageRequestURL),
              let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            completion(nil, NSError(domain: "NetworkService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL or JSON"]))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching image for \(quizName): \(error)")
                if retries > 0 {
                    print("Retrying... attempts left: \(retries - 1)")
                    self.attemptFetchImage(for: quizName, retries: retries - 1, completion: completion)
                } else {
                    completion(nil, error)
                }
            } else if let data = data, let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let imageB64 = jsonResponse["b64_json"] as? String {
                print("Successfully fetched image for \(quizName)")
                // Assuming the API returns a direct URL or base64 encoded string
                completion(imageB64, nil)
            } else {
                print("Failed to decode response for \(quizName)")
                completion(nil, NSError(domain: "NetworkService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"]))
            }
        }
        task.resume()
    }
}
