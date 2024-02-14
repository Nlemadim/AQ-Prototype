//
//  HomeView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/17/24.
//

import SwiftUI
import Foundation

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var user: User
    @EnvironmentObject var quizPlayer: QuizPlayer

    @State private var selectedTab = 0
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ZStack {
                    if user.currentQuiz == nil {
                        VStack {
                        
                            ContentUnavailableView("Download an audio quiz to get started", systemImage: "play.slash")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 320.0) // Match the height of the container
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous)) // Apply material effect on top of the image
                        .shadow(radius: 10, x: 0, y: 10)
                        .padding(.horizontal, 20)
                        
                    } else {
                        VStack(alignment: .center, content: {
                            MainView(user: user, quizPlayer: quizPlayer, imageName: user.currentQuiz?.quizImage ?? "IconImage")
                        })
                    }
  
                }
//                .navigationBarItems(trailing:
//                    Button(action: {
//                    
//                    
//                }, label: {
//                    Image(systemName: "slider.horizontal.3")
//                        .resizable()
//                        .frame(width: 18, height: 18)
//                        .foregroundStyle(.teal).activeGlow(.teal, radius: 0.01)
//                    
//                }))
                /// Hiding tabBar when Sheet is expended
                .toolbar(.visible, for: .tabBar)
                .background(
                    Image("Logo")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
                        .offset(x: 230, y: -100)
                        .opacity(user.currentQuiz != nil ? 0 : 1)
                )
                .preferredColorScheme(.dark)
            }
            
            .tabItem {
                TabIcons(title: "Play", icon: "play.circle")
            }
            .tag(0)
            
            AudioQuizCollectionView()
                .tabItem {
                    TabIcons(title: "Audio Quiz", icon: "magnifyingglass")
                }
                .tag(1)
            
            View3()
                .tabItem {
                    TabIcons(title: "Profile", icon: "person.fill")
                }
                .tag(2)
        }
        .tint(.teal)
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.black
        }
        .safeAreaInset(edge: .bottom) {
            BottomMiniPlayer()
        }
    }
        //.background(Color(image.dominantColor() ?? .gray))
    @ViewBuilder
    func BottomMiniPlayer() -> some View {
        ///Animating Sheet bnackground
        ZStack {
            
            PlayerContentInfo(quizPlayer: quizPlayer)
//            RoundedRectangle(cornerRadius: 10.0)
//                //.fill(.ultraThinMaterial)
//                .overlay {
//                    ///Music Info
//
//                }//.background(Color(user.selectedQuiz?.quizImage.dominantColor() ?? .gray))
        }
        .frame(height: 60)
        .background {
            if let currentQuiz = user.currentQuiz {
                Image(currentQuiz.quizImage)
                    .cornerRadius(100)
                    .blur(radius: 70)
                    .offset(y: 30)
            } else {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(.ultraThinMaterial)
            }
        }
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


//#Preview {
//    let user = User()
//    let quizPlayer = QuizPlayer(user: user)
//    return ContentView()
//        .environmentObject(user)
//        .environmentObject(quizPlayer)
//        .modelContainer(for: [AudioQuizPackage.self, Topic.self], inMemory: true)
//}


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
                .offset(x:  220, y: +230)
                .blur(radius: 30)
        )
    }
}


struct View4: View {
    var body: some View {
        NavigationView {
            ScrollView {
                // Increase spacing here
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(FeaturedQuiz.allCases, id: \.self) { quiz in
                        AudioQuizView(quiz: quiz)
                            .navigationTitle("Practice Exams").navigationBarTitleDisplayMode(.automatic)
                        
                    }
                }
            }
            .preferredColorScheme(.dark)
            .background(
                Image("Logo")
                    .aspectRatio(contentMode: .fit)
                    .offset(x:  120, y: 30)
                    .blur(radius: 20)
            )
        }
    }
}

