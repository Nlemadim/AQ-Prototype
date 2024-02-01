//
//  QuizView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/30/24.
//

import SwiftUI

struct QuizView: View {
    @Binding var expandSheet: Bool
    @State private var offsetY: CGFloat = 0
    @State private var animateContent: Bool = false
    @State var isAnswered: Bool = false
    @State private var viewUpdateID = UUID()
    @ObservedObject var quizPlayer = QuizPlayer()
    var animation: Namespace.ID
    
    var body: some View {
            
            GeometryReader {
                let size = $0.size
                let safeArea = $0.safeAreaInsets
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: animateContent ? deviceCornerRadius : 0, style: .continuous)
                        .fill(.teal)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: animateContent ? deviceCornerRadius : 0, style: .continuous)
                                .fill(.teal.gradient)
                                .opacity(animateContent ? 1 : 0)
                        })
                    
                    
                    if let questionModel = quizPlayer.currentQuestion  {
                        
                        VStack(spacing: 10) {
                            //MARK: Quiz Info Details View
                            QuizInfoDetailsView()
                                .frame(alignment: .topLeading)
                                .overlay(alignment: .top) {
                                    PlayerContentInfo(expandSheet: $expandSheet, quizPlayer: quizPlayer, animation: animation)
                                        .allowsHitTesting(false)
                                        .opacity(animateContent ? 0 : 1)
                                }
                                .matchedGeometryEffect(id: "ICONIMAGE", in: animation)
                                .padding(.horizontal, 5)
                            
                            //MARK: Quiz Visualizer
                            HStack {
                                Text(quizPlayer.questionCounter)
                                    .font(.callout)
                                    .foregroundStyle(.black)
                                Spacer()
                            }
                            .padding(.horizontal, 5)
                            
                            //MARK: Question Content View
                            Text("\(questionModel.questionContent)")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(!isAnswered ? .black : .gray)
                                .lineLimit(6, reservesSpace: true)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                .padding(.horizontal, 5)
                                .onChange(of: questionModel.questionContent, initial: isAnswered) { oldValue,_ in
                                    updateView()
                                }
                            
                            ForEach(questionModel.options, id: \.self) { option in
                                optionButton(questionModel: questionModel, option: option)
                                    .padding(.horizontal, 5)
                            }
                            
                            FullScreenControlView(isNowPlaying: true, quizPlayer: quizPlayer, showQuizControl: {})
                               
                            
                            Spacer()
                        }
                        .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                        .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                        .padding(.horizontal, 5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .clipped()
                    
                    } else {
                        
                        ContentUnavailableView(
                            "You Haven't built a Quiz yet",
                            systemImage: "book.and.wrench.fill",
                            description: Text("You need to buld a quiz to see the questions")
                        )
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
            .onAppear {
                withAnimation(.easeInOut(duration: 0.35)) {
                    animateContent = true
                }
            }
    }
    
    private func updateView() {
        isAnswered.toggle()
    }
    
    @ViewBuilder
    private func optionButton(questionModel: TestQuestionModel, option: String) -> some View {
        let optionColor = colorForOption(option: option, correctOption: questionModel.correctOption, userAnswer: "\(questionModel.selectedOption)")
        
        Button(action: {
            questionModel.selectedOption = option
            isAnswered.toggle()
            //quizPlayer.saveAnswer(for: questionModel.id, answer: questionModel.selectedOption)
        }) {
            Text(option)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(optionColor.opacity(0.15)))
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(optionColor.opacity(optionColor == .black ? 0.15 : 1), lineWidth: 2)
                }
        }
        .disabled(isAnswered && option != questionModel.selectedOption)
    }
    
    private func colorForOption(option: String, correctOption: String, userAnswer: String) -> Color {
        
        if userAnswer.isEmpty {
            return .black
        } else if option == correctOption {
            return .green
        } else if option == userAnswer {
            return .red
        } else {
            return .black
        }
    }
}



//#Preview {
//    QuizView()
//}
