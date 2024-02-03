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
    
    let topics = [
        Topic(name: "Professional Responsibility", generalOverview: "This includes the rules and regulations that govern the conduct of lawyers and judges.", audioNote: "", isPresented: false, inFocus: false),
        Topic(name: "Constitutional Law", generalOverview: "This involves the interpretation and application of the U.S. Constitution.", audioNote: "", isPresented: false, inFocus: false),
        Topic(name: "Criminal Law and Procedure", generalOverview: "This covers the rules for enforcing laws that protect the health, safety, and morals of society.", audioNote: "", isPresented: false, inFocus: false),
        Topic(name: "Evidence", generalOverview: "This involves the rules and legal principles that govern the proof of facts in a legal proceeding.", audioNote: "", isPresented: false, inFocus: false),
        Topic(name: "Real Property", generalOverview: "This covers the law of property, both real estate and personal property.", audioNote: "", isPresented: false, inFocus: false),
        Topic(name: "Torts", generalOverview: "This involves civil wrongs, negligence, and compensation for injuries.", audioNote: "", isPresented: false, inFocus: false),
        Topic(name: "Contracts", generalOverview: "This involves the creation and enforcement of agreements.", audioNote: "", isPresented: false, inFocus: false),
        Topic(name: "Business Associations", generalOverview: "This covers the laws related to corporations, partnerships, and other types of businesses.", audioNote: "", isPresented: false, inFocus: false),
        Topic(name: "Wills and Trusts", generalOverview: "This involves the creation and execution of wills, trusts, and estates.", audioNote: "", isPresented: false, inFocus: false),
        Topic(name: "Civil Procedure", generalOverview: "This covers the process and procedures for conducting a civil lawsuit.", audioNote: "", isPresented: false, inFocus: false)
    ]
    
    
    
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











struct Test: View {
    @Binding var expandSheet: Bool
    @State private var offsetY: CGFloat = 0
    @State private var animateContent: Bool = false
    @ObservedObject var quizPlayer: QuizPlayer
    @State var isAnswered: Bool = false
    var animation: Namespace.ID
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack {
                RoundedRectangle(cornerRadius: animateContent ? deviceCornerRadius : 0, style: .continuous)
                    .fill(.black)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: animateContent ? deviceCornerRadius : 0, style: .continuous)
                            .fill(.teal.gradient)
                            .opacity(animateContent ? 1 : 0)
                    })
                
                if let questionModel = quizPlayer.currentQuestion {
                    VStack(spacing: 8) {
                        QuizInfoDetailsView()
                            .frame(alignment: .topLeading)
                            .overlay(alignment: .top) {
                                PlayerContentInfo(expandSheet: $expandSheet, quizPlayer: quizPlayer, animation: animation)
                                    .allowsHitTesting(false)
                                    .opacity(animateContent ? 0 : 1)
                            }
                            .matchedGeometryEffect(id: "ICONIMAGE", in: animation)
                        
                        HStack {
                            Text(quizPlayer.questionCounter)
                                .font(.callout)
                                .foregroundStyle(.black)
                            Spacer()
                            //Mute Button
                            Button {
                               // isMuted.toggle()
                            } label: {
                                Image(systemName: "speaker.fill")
                                    .foregroundStyle(.themePurple)
                                    .padding(12)
                                    .background {
                                        Circle()
                                            .fill(.ultraThinMaterial)
                                            .environment(\.colorScheme, .light)
                                    }
                            }
                        }
                        
                        Text("\(questionModel.questionContent)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(!isAnswered ? .black : .gray)
                            .lineLimit(6, reservesSpace: true)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .onChange(of: questionModel.questionContent, initial: isAnswered) { oldValue,_ in
                                updateView()
                            }
                        
                        ForEach(questionModel.options, id: \.self) { option in
                            OptionButton(questionModel: questionModel, option: option, quizPlayer: quizPlayer, buttonAction: {
                            })
                        }
                        
                        FullScreenControlView(isNowPlaying: true, quizPlayer: quizPlayer, showQuizControl: {})
                    }
                    .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                    .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                    .padding(.horizontal, 25)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .clipped()
                    
                }
                
            }
            .contentShape(Rectangle())
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let translationY = value.translation.height
                        offsetY = (translationY > 0 ? translationY : 0)
                    }).onEnded({ value in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            if offsetY > size.height * 0.3 {
                                expandSheet = false
                                animateContent = false
                            } else {
                                offsetY = .zero
                            }
                        }
                    })
            )
            .ignoresSafeArea(.container, edges: .all)
        }
        .navigationBarBackButtonHidden(true)
//        .background(
//            Image("Logo")
//                .blur(radius: 50, opaque: true)
//                .ignoresSafeArea()
//                //.offset(x:  220, y: -100)
//            
//        )
        
        .onAppear {
            withAnimation(.easeInOut(duration: 0.35)) {
                animateContent = true
            }
        }
    }
    
    private func updateView() {
        isAnswered.toggle()
    }
}

//#Preview {
//    @StateObject var quizPlayer = QuizPlayer()
//    var animation: Namespace.ID
//    return Test(expandSheet: .constant(false), quizPlayer: quizPlayer, animation: animation)
//        .preferredColorScheme(.dark)
//}

/** message.badge.waveform
 message.badge.waveform.fill
 bubble.right.fill
 bubble.fill
 waveform
 play.desktopcomputer
 desktopcomputer.trianglebadge.exclamationmark
 desktopcomputer
 
 
 
 **/
