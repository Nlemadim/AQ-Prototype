//
//  FullScreenQuizPlayer.swift
//  Exam Genius Audio Quiz Player
//
//  Created by Tony Nlemadim on 1/15/24.
//

import SwiftUI

struct FullScreenQuizPlayer: View {
    @Binding var expandSheet: Bool
    @State var showText: Bool = false
    @State var isMuted: Bool = false
    @State private var offsetY: CGFloat = 0
    @State private var animateContent: Bool = false
    @State private var isNowPlaying: Bool = false
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
                    .overlay(alignment: .top) {
                        PlayerContentInfo(expandSheet: $expandSheet, animation: animation)
                            .allowsHitTesting(false)
                            .opacity(animateContent ? 0 : 1)
                    }
                    .matchedGeometryEffect(id: "ICONIMAGE", in: animation)
                
                VStack(spacing: 15) {
                    /// Grab Indicator
                    Capsule()
                        .fill(.gray)
                        .frame(width: 40, height: 5)
                        .opacity(animateContent ? 1 : 0)
                    /// Matching with Sliding Animation
                        .offset(y: animateContent ? 0 : size.height)
                    ///Player Content View (Hero View)
                    GeometryReader {
                        let size = $0.size
                        if !showText {
                            Image("IconImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width, height: size.height)
                                .clipShape(RoundedRectangle(cornerRadius: animateContent ? 15 : 5, style: .continuous))
                            
                        } else {
                            ScrollView(showsIndicators: false) {
                            
                                Text("Some sample Text Some sample Text Some sample Text Some sample Text Some sample Text Some sample TextSome sample Text Some sample Text Some sample TextSome sample Text Some sample Text Some sample\n\nOption A: TextSome sample Text Some sample Text Some sample TextSome sample Text Some sample Text Some sample TextSome sample\n\nOption B Text Some sample Text Some sample\n\nOption C TextSome sample Text Some sample\n\nOption D Text Some sample Text")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.themePurple)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.leading)
                                    
                            }
                        }
                    }
                    .matchedGeometryEffect(id: "MAINICON", in: animation)
                    /// For Square Content View
                    .frame(height: size.width - 50)
                    /// Dynamically changing Padding for smaller devices
                    .padding(.vertical, size.height < 700 ? 10 : 30)
                    
                    /// Player View
                    PlayerView(size)
                    /// Moving from the bottom of the screen
                        .offset(y: animateContent ? 0 : size.height)
                }
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
            
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
        .onAppear {
            withAnimation(.easeInOut(duration: 0.35)) {
                animateContent = true
            }
        }
    }
    
    @ViewBuilder
    func ListenNow() -> some View {
        
    }
    
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        GeometryReader {
            let size = $0.size
            /// Dynamic Spacing Using Available Height
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    /// Quiz Progress Indicator
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .light)
                        .frame(height: 5)
                        .padding(.top, spacing)
                    
                    /// Question Number View
                    HStack {
                        Spacer()
                        Spacer()
                        Text("Question 6/15")
                            .font(.caption)
                            .foregroundStyle(.themePurple)
                    }
                    
                    /// Quiz Details View
                    HStack(alignment: .center, spacing: 15) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Practice Quiz")
                                .foregroundStyle(.black)
                                .opacity(0.6)
                            
                            Text("New York Bar Exam")
                                .font(.title3)
                                .foregroundStyle(.themePurple)
                                .fontWeight(.semibold)
                                .lineLimit(2, reservesSpace: true)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            showText.toggle()
                        } label: {
                            Image(systemName: "quote.bubble")
                                .foregroundStyle(.themePurple)
                                .padding(12)
                                .background {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .environment(\.colorScheme, .light)
                                }
                        }
                        
                        Button {
                            isMuted.toggle()
                        } label: {
                            Image(systemName: !isMuted ? "speaker.slash.fill" : "speaker")
                                .foregroundStyle(.themePurple)
                                .padding(12)
                                .background {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .environment(\.colorScheme, .light)
                                }
                        }
                    }

                    /// Playback Controls
                    HStack(spacing: size.width * 0.18) {
                        Button {
                            
                        } label: {
                            
                            Image(systemName: "repeat")
                            /// Dynamic Sizing for Smaller to Larger iPhones
                                .font(size.height < 300 ? .title3 : .title)
                                .foregroundStyle(.themePurple)
                        }
                        
                        /// Making Play/Pause Button Slightly Bigger
                        Button {
                            
                        } label: {
                            Image(systemName: isNowPlaying ? "pause.fill" : "play.fill")
                            /// Dynamic Sizing for Smaller to Larger iPhones
                                .font(size.height < 300 ? .largeTitle : .system(size: 50))
                                .foregroundStyle(.themePurple)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "forward.fill")
                            /// Dynamic Sizing for Smaller to Larger iPhones
                                .font(size.height < 300 ? .title3 : .title)
                                .foregroundStyle(.themePurple)
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                    /// Multichoice Option Buttons
                    HStack {
    
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(.themePurple)
                                .frame(width: 60, height: 30)
                                .overlay {
                                    Text("A")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                }
                            
                        }
                        .buttonBorderShape(.roundedRectangle)
                        .foregroundStyle(.themePurpleLight)
                        
                       Spacer(minLength: 0)
                        
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(.themePurple)
                                .frame(width: 60, height: 30)
                                .overlay {
                                    Text("B")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                }
                            
                        }
                        .buttonBorderShape(.roundedRectangle)
                        .foregroundStyle(.themePurpleLight)
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(.themePurple)
                                .frame(width: 60, height: 30)
                                .overlay {
                                    Text("C")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                }
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(.themePurple)
                                .frame(width: 60, height: 30)
                                .overlay {
                                    Text("D")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                }
                            
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(maxHeight: .infinity)
                    
                    Spacer(minLength: 0)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
