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
                    VStack(alignment: .center, content: {
                            QuizPlayerDashboard(user: user, quizPlayer: quizPlayer)
                    })
                    .offset(y: -33)
               
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
            
            View4()
                .tabItem {
                    TabIcons(title: "Exams", icon: "magnifyingglass")
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
                        PlayerContentInfo(quizPlayer: quizPlayer)
                    }
            }
        }
        .frame(height: 60)
        
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
                        ExamTypeView2(quiz: quiz)
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



/*AUdio_Quiz_Beta.Question
 file:///Users/tonynlemadim/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/F02E2872-D721-4DA5-B776-BE82E5276093/data/Containers/Data/Application/E8822FF0-533F-403F-B0DF-EE5A09D7D60C/Documents/93D64F35-E2F9-4834-985A-6A27DD1B674D.mp3
 AUdio_Quiz_Beta.Question
 file:///Users/tonynlemadim/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/F02E2872-D721-4DA5-B776-BE82E5276093/data/Containers/Data/Application/E8822FF0-533F-403F-B0DF-EE5A09D7D60C/Documents/63648781-94B7-4A3D-8B1D-E017BC4D5D74.mp3
 AUdio_Quiz_Beta.Question
 file:///Users/tonynlemadim/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/F02E2872-D721-4DA5-B776-BE82E5276093/data/Containers/Data/Application/E8822FF0-533F-403F-B0DF-EE5A09D7D60C/Documents/F4FEDA73-589C-4531-83CA-38A7CBF99A77.mp3
 AUdio_Quiz_Beta.Question
 file:///Users/tonynlemadim/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/F02E2872-D721-4DA5-B776-BE82E5276093/data/Containers/Data/Application/E8822FF0-533F-403F-B0DF-EE5A09D7D60C/Documents/F472347E-61EA-4AF6-8389-F05A3DD2D339.mp3
 AUdio_Quiz_Beta.Question
 file:///Users/tonynlemadim/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/F02E2872-D721-4DA5-B776-BE82E5276093/data/Containers/Data/Application/E8822FF0-533F-403F-B0DF-EE5A09D7D60C/Documents/41209A0F-72DC-4BFA-A801-442569030813.mp3
 AUdio_Quiz_Beta.Question
 file:///Users/tonynlemadim/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/F02E2872-D721-4DA5-B776-BE82E5276093/data/Containers/Data/Application/E8822FF0-533F-403F-B0DF-EE5A09D7D60C/Documents/277C30AA-2A29-4624-9918-7DFDF368A38B.mp3
 AUdio_Quiz_Beta.Question
 file:///Users/tonynlemadim/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/F02E2872-D721-4DA5-B776-BE82E5276093/data/Containers/Data/Application/E8822FF0-533F-403F-B0DF-EE5A09D7D60C/Documents/97149C5E-1C2B-488D-9FBC-7C0D330332F2.mp3
 AUdio_Quiz_Beta.Question
 file:///Users/tonynlemadim/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/F02E2872-D721-4DA5-B776-BE82E5276093/data/Containers/Data/Application/E8822FF0-533F-403F-B0DF-EE5A09D7D60C/Documents/A52996C3-20A7-4184-9622-2D9D1AC23255.mp3
 AUdio_Quiz_Beta.Question
 file:///Users/tonynlemadim/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/F02E2872-D721-4DA5-B776-BE82E5276093/data/Containers/Data/Application/E8822FF0-533F-403F-B0DF-EE5A09D7D60C/Documents/DAA1DDE9-C2FC-4F23-969C-3DF1FF00A84A.mp3
 AUdio_Quiz_Beta.Question
 file:///Users/tonynlemadim/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/F02E2872-D721-4DA5-B776-BE82E5276093/data/Containers/Data/Application/E8822FF0-533F-403F-B0DF-EE5A09D7D60C/Documents/8EC57D75-4694-45F0-AC7C-608DC38F1E8D.mp3*/
