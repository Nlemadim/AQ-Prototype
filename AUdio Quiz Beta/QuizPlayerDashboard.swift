//
//  QuizPlayerDashboard.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/8/24.
//

import SwiftUI

struct QuizPlayerDashboard: View {
    @StateObject var user: User
    @StateObject var quizPlayer: QuizPlayer
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                QuizDashboardInfoDetailsView(user: user)
                QuizDashboardView(question: quizPlayer.currentQuestion, options: quizPlayer.currentQuestion?.options ?? [])
            }
            .padding(.top, 30)
            .padding(.bottom, 10)
        }
    }
}

struct QuizDashboardInfoDetailsView: View {
    @StateObject var user: User
    @State var shortName: String = "Audio Quiz"
    @State var longName: String = "New York Bar Exam"
    @State var iconImage: String = "IconImage"
    
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 15) {
                /// Exam Icon Image
                Image(iconImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                if let selectedQuiz = user.selectedQuiz {
                    VStack(alignment: .leading, spacing: 4) {
                        /// Short Name
                        Text("Audio Quiz")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                        /// Long Name
                        Text(selectedQuiz.quizName)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .lineLimit(2, reservesSpace: false)
                            .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        
                        Text("\(selectedQuiz.questions.count) Questions".uppercased())
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                } else {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("No Quiz Selected")
                            .foregroundStyle(.primary)
                        Image(systemName: "recordingtape")
                            .foregroundStyle(.secondary)
                            .font(.caption)

                    }
                    .frame(maxWidth: .infinity)
                    //.padding(.all, 20.0)

                }
            }
            .padding(.all, 20.0)
            .padding(.vertical, 20)
            .frame(height: 140.0)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous)) // Apply material effect on top of the image
            .shadow(radius: 10, x: 0, y: 10)
            .padding(.horizontal, 5)
            
        }
    }
}

//#Preview(body: {
//    @ObservedObject var selectedQuiz: UserSelectedQuiz
//    return QuizPlayerDashboard(selectedQuiz: selectedQuiz)
//})

struct QuizDashboardView: View {
    @State var question: Question?
    @State var options: [String]
    
    var body: some View {
        if self.question == nil {
            VStack(alignment: .center) {
                ContentUnavailableView(
                    "Empty!",
                    systemImage: "recordingtape",
                    description: Text("Download and select Audio Quiz to start")
                )
                
                DashboardSettingsView()
            }
            .padding(.all, 20.0)
            .padding(.vertical, 20)
            .frame(height: 450.0)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous)) // Apply material effect on top of the image
            .shadow(radius: 10, x: 0, y: 10)
            .padding(.horizontal, 5)
            
        } else {
            
            VStack(alignment: .center, spacing: 10) {
                DashboardInteractionVisualizer()
          
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(question?.questionContent ?? "")
                            .padding(.top, 2)
              
                        Text(options[0])
                            .font(.body)
                        
                        Text(options[1])
                            .font(.body)
                        
                        Text(options[2])
                            .font(.body)
                        
                        Text(options[3])
                            .font(.body)
                    }
                    .padding(.top, 5)
                }
                
                DashboardSettingsView()
            }
            .padding([.top, .leading, .trailing], 20.0)
            .padding(.vertical, 20)
            .frame(height: 450.0)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous)) // Apply material effect on top of the image
            .shadow(radius: 10, x: 0, y: 10)
            .padding(.horizontal, 5)
            .ignoresSafeArea()
        }
    }
}



struct DashboardInteractionVisualizer: View {
    @State var comment: String = ""
    @State var correctOption: String = ""
    @State var isPlaying: Bool = false

    var body: some View {
            HStack(spacing: 35) {
                Button(action: {
                    
                }, label: {
                   Image(systemName: "play.desktopcomputer")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.teal)
                })
                
                Spacer()

                Image(systemName: "waveform")
                    .resizable()
                    .foregroundStyle(.themeTeal)
                    .symbolEffect(.variableColor.iterative.dimInactiveLayers.reversing, options: .repeating, isActive: isPlaying)
                    .frame(width: 23, height: 23)
                    .opacity(isPlaying ? 1  : 0)
                
                Spacer()

                HStack(spacing: 0) {
                    ZStack {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .foregroundStyle(.white)
                            .symbolEffect(.scale.wholeSymbol, options: .nonRepeating, isActive: !comment.isEmpty)
                            .frame(width: 23, height: 23)
                            .offset(y: -10)
                            .padding(.leading, 3)
                            .opacity(comment.isEmpty ? 0 : 1)

                        Text(comment.isSingleCharacterABCD ? comment : "")
                            .font(.caption)
                            .fontWeight(.bold)
                            .offset(y: -8)
                            .foregroundStyle(.white)
                    }

                    Button(action: {
                        
                    }, label: {
                       Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(.teal)
                    })
                }
            }
            .frame(maxWidth: .infinity) 
    }
}

struct DashboardSettingsView: View {
    @State private var fillAmount: CGFloat = 0.0
    @State private var showProgressRing: Bool = false
    var body: some View {
        HStack {
            // Timer on Indicator
            Button(action: {}) {
                Image(systemName: "alarm.fill")
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            
           Spacer(minLength: 5)
//            // Record Button with Progress Ring
            Button(action: {}) {
                Image(systemName: "mic.slash.fill")
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            
            Spacer(minLength: 5)

            // Learning Mode Indicator
            Button(action: {}) {
                Image(systemName: "book.fill")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
            
        }
        .frame(height: 50.0)
        .background(.gray.opacity(0.6), in: RoundedRectangle(cornerRadius: 10, style: .continuous)) // Apply material effect on top of the image
        .shadow(radius: 20, x: 0, y: 10)
    }
    
    private func startFilling() {
        fillAmount = 0.0 // Reset the fill amount
        showProgressRing = true // Show the progress ring
        withAnimation(.linear(duration: 5)) {
            fillAmount = 1.0 // Fill the ring over 5 seconds
        }
        // Hide the progress ring after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showProgressRing = false
        }
    }

}
