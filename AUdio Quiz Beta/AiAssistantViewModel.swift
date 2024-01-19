//
//  AiAssistantViewModel.swift
//  ExamGenius
//
//  Created by Tony Nlemadim on 12/29/23.
//

import SwiftUI
import AVFoundation

class AiAssistantViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var messages: [String] = []  // Messages to be displayed to the user.
    @Published var currentContentView: ContentViewType = .none  // The type of content currently displayed.
    @Published var contentView: AiAssistantContentView  // Content view to display messages or actions.

    // Sample prompts for quick actions.
    let samplePrompts = ["Tell me what you can do","Show me some standard exams", "Build me a quiz on...", "Show me the most taken quizzes", "Go to my Resources", "Go to my settings", "Start a quiz"]
    
    // Enumeration of possible contexts based on user input.
    enum Context {
        case greeting, examInfo, settings, error, resources, takeAQuiz, aboutExamGenius, whatYouCanDo, addAnImage, addADocument, readOutLoud, mute, showMeMyPerFormance, showMeMyActivity, readOutMyTopics
        // Add more contexts as needed
    }
    
    // Enumeration of content view types.
    enum ContentViewType {
        case image, document, text, none
        // Add more content types as needed
    }
    
    // Enumeration of actions that can be performed.
    enum Action {
        case showExams, openSettings, rejectRequest, openActivity, openResources, readOutItems, goSilent, openDocuments, openPhotos, describeApp, describeAiActions
        // Add more actions as needed
    }
    
    // MARK: - Initialization
    init() {
        self.contentView = AiAssistantContentView(profileImage: Image("VigilHeadshot"), content: .text("Welcome!"), isProcessing: false)
    }
    
}

#Preview {   
    AiAssistant()
}
