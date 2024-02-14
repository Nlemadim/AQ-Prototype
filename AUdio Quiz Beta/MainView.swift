//
//  MainView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/13/24.
//

import SwiftUI

struct MainView: View {
    let user: User
    let quizPlayer: QuizPlayer
    var imageName: String
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            ZStack(alignment: .bottomTrailing) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
            }
            
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: .continuous)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundStyle(.clear)
                .overlay {
                    HStack(spacing: 10) {
                        SettingsGrid()
                        SecondaryPlayerControlGrid()
                    }
                    .padding(.horizontal)
                    
                }
            
            VStack(alignment: .center, spacing: 10) {
                QuestionContentExpandableView(contentInfo: quizPlayer.questionCounter, currentContent: user.currentPlayPosition)
               
            }
            .background {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit) // Fill the available space
                    .frame(height: 320.0) // Match the height of the container
                    .cornerRadius(100)
                    .blur(radius: 70)
                    .offset(y: 30)
            }
            
            CurrentTopicsView(topics: user.currentQuiz?.topics ?? [])
        }
        .scrollBounceBehavior(.basedOnSize)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    @StateObject var user = User()
    @StateObject var quizPlayer = QuizPlayer(user: User())
    return MainView(user: user, quizPlayer: quizPlayer, imageName: "Logo")
}

struct MainViewModel {
    var name: String
    var imageName: String
    var image: UIImage
    var quizThemeColor: Color
    var buttonLabel: String
    var isUsingMic: Bool
    var learningModeOn: Bool
    var timerOn: Bool
    var micImage: String
    var learnImage: String
    var timerImage: String
}

struct SettingsGrid: View {
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "alarm.fill")
                .font(.title2)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Image(systemName: "book.fill")
                .font(.title2)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Image(systemName: "mic.slash.fill")
                .font(.title2)
                .foregroundColor(.secondary)
                .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct SecondaryPlayerControlGrid: View {
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            Image(systemName: "stop.fill")
                .font(.title)
                .foregroundColor(.primary)
                .padding(.horizontal)
            
            Image(systemName: "forward.end.alt.fill")
                .font(.title)
                .foregroundColor(.primary)
                .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct QuestionContentExpandableView: View {
    @State var isExpanded: Bool = false
    @State var hasContent: Bool = false
    @State var contentInfo: String
    var currentContent: Int
    var audioQuiz: DownloadedAudioQuiz?
    var body: some View {
        VStack {
            if let audioQuiz, !audioQuiz.contents.isEmpty {
                let content = audioQuiz.contents
                QuizContentView(content: content, content: currentContent, isExpanded: isExpanded, contentInfo: contentInfo)
            } else {
                ContentUnavailableView("You haven't selected an Audio Quiz", systemImage: "play.slash")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                
            }
            
            HStack {
                Spacer()
                Spacer()
                
                Button(action: {
                    self.isExpanded.toggle()
                }, label: {
                    Image(systemName: isExpanded ? "arrow.down.forward.and.arrow.up.backward.square": "arrow.up.left.and.arrow.down.right")
                        .font(.title)
                        .foregroundColor(.secondary)
                    //.padding(.horizontal)
                })
            }
        }
        .padding(.all, 15.0)
        //.padding(.vertical, 20)
        .frame(height: isExpanded ? 750.0 : 350.0)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous)) // Apply material effect on top of the image
        .shadow(radius: 10, x: 0, y: 10)
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    func QuizContentView(content: [Question], content index: Int, isExpanded: Bool, contentInfo: String)  -> some View {
        if !isExpanded {
            VStack(spacing: 5) {
                
                HStack {
                    Text(contentInfo)
                        .font(.callout)
                    Spacer()
                }
                
                Text("\(content[index].questionContent)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
            
        } else {
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading , spacing: 10) {
                    //Question
                    Text("\(content[index].questionContent)")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    //Options
                    Text("\(content[index].options[0])")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Text("\(content[index].options[1])")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Text("\(content[index].options[2])")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Text("\(content[index].options[3])")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                }
            }
        }
    }
}

struct CurrentTopicsView: View {
    
    var topics: [Topic]
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack {
                Text("Topics")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
            }
            .padding(.trailing)
            .padding(.all, 20.0)
            VStack {
                if topics.isEmpty {
                    VStack {
                        ContentUnavailableView(label: {
                            Label("No Quiz Topics", systemImage: "doc.on.doc")
                        }, description: {
                            Text("Select an Audio Quiz")
                        })
                    }
                    .preferredColorScheme(.dark)
                    .padding(.all, 30)
                    
                } else {
                    List {
                        ForEach(topics) { topic in
                            Text("\(topic.name)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                        }
                    }
                }
            }
        }
    }
}
