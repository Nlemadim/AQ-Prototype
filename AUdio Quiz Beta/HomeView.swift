//
//  HomeView.swift
//  Exam Genius Audio Quiz Player
//
//  Created by Tony Nlemadim on 1/17/24.
//

import SwiftUI
import Foundation

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var user: User
    @State private var expandSheet: Bool = false
    @State private var isSignedIn: Bool = false
    @State private var isPlaying: Bool = false
    @State private var selectedTab = 0
    @StateObject var quizPlayer: QuizPlayer
    @State var userItems: [String] = ["Featured", "Recents", "Current" ]
    
    @Namespace private var animation
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ZStack {
                
                    ScrollView {
                        GeometryReader { proxy in
                            Text("Featured")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding()
                        }
                        .frame(height: 0)
                        
                        TabView {
                                ForEach(FeaturedQuiz.allCases, id: \.self) { quiz in
                                    SampleExam(featuredQuiz: quiz, questions: quiz.questions, playButtonAction: {
                                        user.selectedQuiz = UserSelectedQuiz(from: quiz)
                                        //print(user.selectedQuiz?.quizName)
                                    })
                                    // Add any additional styling or properties here
                                }
                        }
                        
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: 560)
                        
                    }
                }
                .navigationBarItems(trailing:
                                        Button(action: {
                    
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.teal).activeGlow(.teal, radius: 0.01)
      
                }))
                /// Hiding tabBar when Sheet is expended
                .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
                .background(
                    Image("Logo")
                        .offset(x: 230, y: -100)
                    
                )
                .preferredColorScheme(.dark)
            }
            
            .tabItem {
                TabIcons(title: "Play", icon: "play.circle")
            }
            .tag(0)
            
            ExamList()
                .tabItem {
                    TabIcons(title: "Exams", icon: "magnifyingglass")
                }
                .tag(1)
            
            TopicsListView()
                .tabItem {
                    TabIcons(title: "Topics", icon: "list.bullet.rectangle")
                }
                .tag(2)
            
            View3()
                .tabItem {
                    TabIcons(title: "History", icon: "scroll")
                }
                .tag(3)
        }
        .tint(.teal)
        .safeAreaInset(edge: .bottom) {
            BottomMiniPlayer()
        }
        .overlay {
            if expandSheet {
                QuizView(expandSheet: $expandSheet, quizPlayer: quizPlayer, animation: animation)
                //Transition Animation
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
    }
    
    @ViewBuilder
    func BottomMiniPlayer() -> some View {
        ///Animating Sheet bnackground
        ZStack {
            if expandSheet {
                Rectangle()
                    .fill(.clear)
            } else {
                Rectangle()
                    .fill(.black)
                    .overlay {
                        ///Music Info
                        PlayerContentInfo(expandSheet: $expandSheet, quizPlayer: quizPlayer, animation: animation)
                    }
                    .matchedGeometryEffect(id: "MAINICON", in: animation)
            }
        }
        .frame(height: 70)
        
        ///Seperator LIne
        .overlay(alignment: .bottom, content: {
            Rectangle()
                .fill(.teal.opacity(0.3))
                .frame(height: 1)
                .offset(y: -5)
        })
        ///Default Height set to 49
        .offset(y: -49)
    }
    
}


struct TabIcons: View {
    var title: String
    var icon: String
    
    var body: some View {
        // Tab Icons content here
        Label(title, systemImage: icon)
    }
}



#Preview {
    let user = User()
    let quizPlayer = QuizPlayer(user: user)
    return ContentView()
        .environmentObject(user)
        .environmentObject(quizPlayer)
        .modelContainer(for: [ExamType.self, Topic.self], inMemory: true)
}




struct View3: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            VStack {
                Text("User History Page")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(alignment: .topLeading)
            }
        }
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
        .background(
            Image("Logo")
                .offset(x:  220, y: -130)
                .blur(radius: 30)
            
        )
        
    }
}

struct View4: View {
    var body: some View {
        ZStack {
            Text("This is View 4")
        }
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
        .background(
            Image("Logo")
                .offset(x:  220, y: -100)
            
        )
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
}

