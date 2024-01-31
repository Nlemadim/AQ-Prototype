//
//  Test.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/24/24.
//

import SwiftUI


class TestClass: ObservableObject {
    @Published var color: Color = .green
    @Published var number: Int = 0
    
    func changeColor() {
        if self.number > 10 {
            self.color = .red
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
