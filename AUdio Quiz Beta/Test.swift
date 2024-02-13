//
//  Test.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/24/24.
//

import SwiftUI
import SwiftData
import Combine


class TestTopicGenerator: ObservableObject {
    @Published var color: Color = .green
    @Published var number: Int = 0
    
    //    let topics = [
    //        Topic(name: "Professional Responsibility", generalOverview: "This includes the rules and regulations that govern the conduct of lawyers and judges.", audioNote: "", isPresented: false, inFocus: false),
    //        Topic(name: "Constitutional Law", generalOverview: "This involves the interpretation and application of the U.S. Constitution.", audioNote: "", isPresented: false, inFocus: false),
    //        Topic(name: "Criminal Law and Procedure", generalOverview: "This covers the rules for enforcing laws that protect the health, safety, and morals of society.", audioNote: "", isPresented: false, inFocus: false),
    //        Topic(name: "Evidence", generalOverview: "This involves the rules and legal principles that govern the proof of facts in a legal proceeding.", audioNote: "", isPresented: false, inFocus: false),
    //        Topic(name: "Real Property", generalOverview: "This covers the law of property, both real estate and personal property.", audioNote: "", isPresented: false, inFocus: false),
    //        Topic(name: "Torts", generalOverview: "This involves civil wrongs, negligence, and compensation for injuries.", audioNote: "", isPresented: false, inFocus: false),
    //        Topic(name: "Contracts", generalOverview: "This involves the creation and enforcement of agreements.", audioNote: "", isPresented: false, inFocus: false),
    //        Topic(name: "Business Associations", generalOverview: "This covers the laws related to corporations, partnerships, and other types of businesses.", audioNote: "", isPresented: false, inFocus: false),
    //        Topic(name: "Wills and Trusts", generalOverview: "This involves the creation and execution of wills, trusts, and estates.", audioNote: "", isPresented: false, inFocus: false),
    //        Topic(name: "Civil Procedure", generalOverview: "This covers the process and procedures for conducting a civil lawsuit.", audioNote: "", isPresented: false, inFocus: false)
    //    ]
    //
    
    
}

class TestQuestionAudioGenerator: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    @Published var color: Color = .green
    @Published var questioNumber: Int = 0
    @Published var completeQuestions: [Question] = []
    
    private let networkService: NetworkService = NetworkService.shared
    
    static let shared = TestQuestionAudioGenerator()
    
    private init() {}
    
    
    //MARK: Group question content update. To be Called when this exam is selected.
    func updateQuestionGroup(questions: [Question]) async {
        for question in questions {
            print(question)
            
            await self.generateAudioQuestion(question: question)
            
            //print("Error generating audio for question: \(question.questionContent)")
        }
    }
    
    
    private func formatQuestionForReadOut(questionContent: String, options: [String]) -> String {
        self.questioNumber += 1
        
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
    
    private func updateQuestionAudioContent(question: Question, audioFilePath: String) {
        question.questionAudio = audioFilePath
        //modelContext.insert(question)
    }
    
    private func generateAudioQuestion(question: Question) async {
        let readOut = formatQuestionForReadOut(questionContent: question.questionContent, options: question.options)
        
        do {
            let audioFile = try await networkService.fetchAudioData(content: readOut)
            let fileUrl = saveAudioDataToFile(audioFile)
            updateQuestionAudioContent(question: question, audioFilePath: fileUrl.path)
            
            // Update completeQuestions on the main thread
            DispatchQueue.main.async {
                self.completeQuestions.append(question)
            }
        } catch {
            print(error.localizedDescription) //MARK: TODO: Modify for retry
        }
    }
}

import SwiftUI

struct TestExamsCollectionView: View {
    @State var testCollection: [TestAudioQuizPackage] = []
    private let networkService: NetworkService = NetworkService.shared
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(testCollection, id: \.self) { quiz in
                    TestAudioQuizPackageView(quiz: quiz)
                }
            }
            
            Button("Download Quiz") {
                Task {
                    // Replace with your actual image URL
                    await createAudioQuizCollection()
                }
            }
            .padding()
            .buttonBorderShape(.capsule)
            .buttonStyle(.bordered)
            
            Button("Download Images") {
                Task {
                    for quiz in testCollection {
                        await fetchImages(for: quiz.name)
                    }
                }
            }
            .padding()
            .buttonBorderShape(.capsule)
            .buttonStyle(.bordered)
            
        }
    }
    
    func createAudioQuizCollection() async {
        let defaultCollection: [DefaultAudioQuizCollection] = [.architectRegistrationExam, .cfpExam]
        
        defaultCollection.forEach { quizName in
            let newAudioQuiz = TestAudioQuizPackage(id: UUID(), name: quizName.rawValue)
            self.testCollection.append(newAudioQuiz)
        }
    }
    
    func fetchImages(for quizName: String) async {
        do {
            let imageB64 = try await fetchSingleImage(for: quizName)
            
            guard let imageData = Data(base64Encoded: imageB64) else {
                throw NSError(domain: "Base64DecodingError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode base64 string"])
            }
            
            if let fileUrl = saveImageToDocuments(data: imageData) {
                // Find the quiz object and update its imageUrl
                if let index = testCollection.firstIndex(where: { $0.name == quizName }) {
                    testCollection[index].imageUrl = fileUrl.absoluteString
                }
            } else {
                throw NSError(domain: "ImageSavingError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Failed to save image"])
            }
        } catch {
            print("Error fetching image for \(quizName): \(error.localizedDescription)")
            // Handle error (e.g., show an error message to the user)
        }
    }

    
    func fetchSingleImage(for quizName: String, retryCount: Int = 0) async throws -> String {
        print("Calling Network")
        var components = URLComponents(string: Config.imageRequestURL)
        components?.queryItems = [URLQueryItem(name: "examName", value: quizName)]
        
        guard let apiURL = components?.url else {
            throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                throw NSError(domain: "NetworkService", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch image with status code \(statusCode)"])
            }
            
            guard let imageB64 = String(data: data, encoding: .utf8) else {
                throw NSError(domain: "NetworkService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
            }
            
            return imageB64
        } catch let error as NSError {
            if error.code == 429, retryCount < 3 { // Example retry logic for HTTP 429 errors
                let retryDelay = pow(2.0, Double(retryCount)) // Exponential backoff
                print("Retrying in \(retryDelay) seconds...")
                try await Task.sleep(nanoseconds: UInt64(retryDelay * 1_000_000_000))
                return try await fetchSingleImage(for: quizName, retryCount: retryCount + 1)
            } else {
                throw error
            }
        }
    }
    
    // Helper method to save image data to the Documents directory and return the file URL
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

// Example usage:


#Preview {
    TestExamsCollectionView()
        .preferredColorScheme(.dark)
}



class TestAudioQuizPackage: ObservableObject, Identifiable, Equatable {
    var id: UUID
    var name: String
    var acronym: String
    var about: String
    var imageUrl: String
    var category: String
    
    
    init(id: UUID) {
        self.id = id
        self.name = ""
        self.acronym = ""
        self.about = ""
        self.imageUrl = ""
        self.category = ""
        
    }
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
        self.acronym = ""
        self.about = ""
        self.imageUrl = ""
        self.category = ""
        
    }
    
    static func == (lhs: TestAudioQuizPackage, rhs: TestAudioQuizPackage) -> Bool {
        return lhs.id == rhs.id
    }
}

extension TestAudioQuizPackage: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


struct TestAudioQuizPackageView: View {
    var quiz: TestAudioQuizPackage
    
    var body: some View {
        ZStack {
            // Determine the image to display based on availability of imageUrl
            if quiz.imageUrl.isEmpty {
                Image("IconImage") // Ensure this image is in your assets
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180, height: 260)
                    .cornerRadius(20)
            } else {
                Image(quiz.imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180, height: 260)
                    .cornerRadius(20)
            }
            
            // Overlay for name or loading indicator
            VStack {
                Spacer()
                if quiz.name.isEmpty {
                    // Display a ProgressView if the name is empty
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    // Display the name if it's available
                    Text(quiz.name)
                        .font(.callout)
                        .lineLimit(3, reservesSpace: true)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(5)
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.7))
                    
                }
            }
        }
        .frame(width: 180, height: 260)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

