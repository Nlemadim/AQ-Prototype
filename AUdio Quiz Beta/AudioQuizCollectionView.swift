//
//  AudioQuizCollectionView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/9/24.
//

import SwiftUI
import SwiftData


struct AudioQuizCollectionView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = AudioQuizCollectionVM()
    @State private var path = [AudioQuizPackage]()
    @Query(sort: \AudioQuizPackage.name) var audioQuizCollection: [AudioQuizPackage]
    
    private let networkService: NetworkService = NetworkService.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Sample Collection Section
                        Text("Sample Collection")
                            .font(.headline)
                            .padding(.leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(.fixed(200))], spacing: 20) {
                                ForEach(FeaturedQuiz.allCases.prefix(5), id: \.self) { quiz in // Assuming 'FeaturedQuiz' is a placeholder
                                    AudioQuizView(quiz: quiz) // Assuming this view takes a quiz and displays it
                                        .frame(width: 180, height: 260)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Complete Collection Section
                        Text("Full Collection")
                            .font(.headline)
                            .padding(.leading)
                        
                        // Dynamically calculate placeholders to display based on actual items available
                        let placeholderCount = max(0, 20 - audioQuizCollection.count)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            // Display actual items
                            ForEach(audioQuizCollection, id: \.self) { quiz in
                                AudioQuizPackageView(quiz: quiz)
                            }
                            
                            // Display placeholders
                            ForEach(0..<placeholderCount, id: \.self) { _ in
                                AudioQuizPlaceHolder()
                                    .frame(height: 260)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Audio Quiz Collection")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                Image("Logo")
                    .offset(x:  220, y: +230)
                    .blur(radius: 30)
            )
            .task {
                if audioQuizCollection.isEmpty {
                    await createAudioQuizCollection()
                }
                
                //await fetchAndUpdateImagesForQuizzes()
            }
        }
    }
    
    func createAudioQuizCollection() async {
        let defaultCollection = DefaultAudioQuizCollection.allCases
        var image = ""
        
        defaultCollection.forEach { quizName in
            let newAudioQuiz = AudioQuizPackage(id: UUID(), name: quizName.rawValue)
            modelContext.insert(newAudioQuiz)
            try! modelContext.save()
            
        }
    }
    
    
    
    func fetchAndUpdateImagesForQuizzes() async {
        // Assuming you have a way to obtain the quiz names from `audioQuizCollection`
        let quizNames = audioQuizCollection.map { $0.name }
        
        // Fetch images for these quizzes
        let imageMappings = await networkService.fetchImages(for: quizNames)
        
        // Update the quizzes with their corresponding images
        for quiz in audioQuizCollection {
            if let imageUrl = imageMappings[quiz.name] {
                // Perform the update on the main thread
                    quiz.imageUrl = imageUrl ?? ""
                    //self.modelContext.insert(quiz)
                    // Save the updated quiz object to your model context as necessary
            }
        }
    }
}

#Preview {
    AudioQuizCollectionView()
        .modelContainer(for: [AudioQuizPackage.self],
                        inMemory: true
        )
        .preferredColorScheme(.dark)
}
