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
    @State private var expandSheet: Bool = false
    @State private var isSignedIn: Bool = false
    @State private var isPlaying: Bool = false
    @State private var selectedTab = 0
    @StateObject var quizPlayer: QuizPlayer
    
    
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
                            ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                                FeaturedItem()
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(height: 500)
                        
                        HStack(spacing: 15) {
                            Button {
                                
                            } label: {
                                Text("Sign Up")
                                    .foregroundStyle(.themePurple)
                                    .fontWeight(.semibold)
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Button {
                                
                            } label: {
                                Text("Login")
                                    .foregroundStyle(.themePurple)
                                    .fontWeight(.semibold)
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
                .navigationBarItems(trailing: Image(systemName: "magnifyingglass.circle"))
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
//    @StateObject var quizPlayer = QuizPlayer()
//    return HomeView(quizPlayer: quizPlayer)
    ContentView()
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

