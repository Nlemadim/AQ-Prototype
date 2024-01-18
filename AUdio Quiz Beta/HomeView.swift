//
//  HomeView.swift
//  Exam Genius Audio Quiz Player
//
//  Created by Tony Nlemadim on 1/17/24.
//

import SwiftUI
import Foundation

struct HomeView: View {
    @State private var expandSheet: Bool = false
    @State private var isSignedIn: Bool = false
    @State private var selectedTab = 0
    
    
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
                TabIcons(title: "Quiz Player", icon: "play.circle")
            }
            .tag(0)
            
            View1()
            .tabItem {
                TabIcons(title: "Topic Notes", icon: "list.bullet.rectangle")
            }
            .tag(1)
            
            View2()
            .tabItem {
                TabIcons(title: "Build Quiz", icon: "wand.and.stars.inverse")
            }
            .tag(2)
            
            View3()
            .tabItem {
                TabIcons(title: "History", icon: "scroll")
            }
            .tag(3)
            
            View4()
            .tabItem {
                TabIcons(title: "Profile", icon: "person.fill")
            }
            .tag(4)
            
        }
        .tint(.teal)
        .safeAreaInset(edge: .bottom) {
            BottomMiniPlayer()
        }
        .overlay {
            if expandSheet {
                FullScreenQuizPlayer(expandSheet:  $expandSheet, animation: animation)
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
                        PlayerContentInfo(expandSheet: $expandSheet, animation: animation)
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


struct FeaturedItem: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "play.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 26.0, height: 26.0)
                    .cornerRadius(10)
                    .padding(9)
                    .foregroundStyle(.teal)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            
            //.strokeStyle(cornerRadius: 16)
            Text("Practice New York Bar Exam")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
            Text("5 Questions".uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            Text("Sample Audio Quiz")
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2, reservesSpace: true)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.all, 20.0)
        .padding(.vertical, 20)
        .frame(height: 350.0)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 10)
        .padding(.horizontal, 20)
        
        .overlay(
            //Image(systemName: "headphones")
            Image("Legal")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(height: 130)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .offset(x: 32, y: -80)
        )
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
    HomeView()
}

struct View1: View {
    var body: some View {
        ZStack {
            Text("This is View 1")
        }
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
        .background(
            Image("Logo")
                .offset(x: 220, y: -100)
            
        )
    }
}

struct View2: View {
    var body: some View {
        ZStack {
            Text("This is View 2")
        }
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
        .background(
            Image("Logo")
                .offset(x:  220, y: -100)
            
        )
    }
}

struct View3: View {
    var body: some View {
        ZStack {
            Text("This is View 3")
        }
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
        .background(
            Image("Logo")
                .offset(x:  220, y: -100)
            
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

import SwiftUI

struct ContentView3: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                Text("View1")
                    .navigationBarTitle("View1", displayMode: .inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                print("Magnifying glass tapped!")
                            }) {
                                Image(systemName: "magnifyingglass")
                            }
                        }
                    }
            }
            .tabItem {
                Label("View1", systemImage: "1.square.fill")
            }
            .tag(0)
            
            // Repeat for View2, View3, View4, View5
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
