//
//  TopicsGenerator.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/12/24.
//

import Foundation
import SwiftUI

extension QuizBuilder {
    class TopicGenerator {
        private let networkService: NetworkService = NetworkService.shared
        let builder: QuizBuilder
        
        init(builder: QuizBuilder) {
            self.builder = builder
        }
        
        private func fetchTopicNames(context: String) async throws -> [String] {
            return try await networkService.fetchTopics(context: context)
        }
        
        func buildAudioQuizTopics(_ audioQuiz: AudioQuizPackage) async {
            Task {
                let fetchedTopics = try await fetchTopicNames(context: audioQuiz.name)
                
                for topic in fetchedTopics {
                    let newTopic = Topic(name: topic)
                    audioQuiz.topics.append(newTopic)
                }
            }
            
            //Calling Parent class property
            builder.modelContext.insert(audioQuiz)
            try! builder.modelContext.save()
        }
    }
}
