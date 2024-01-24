//
//  AiAssistant.swift
//  ExamGenius
//
//  Created by Tony Nlemadim on 12/29/23.
//

import SwiftUI
import PhotosUI  // For image picker

struct AiAssistant: View {
    @StateObject private var viewModel = AiAssistantViewModel()
    @State private var userRequest: String = ""
    @State private var isExpanded: Bool = false
    @State private var topInset: CGFloat = 0
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            ScrollView {
                
                VStack(spacing: 10) {
                    VStack {
                        
                        ScrollView(.horizontal, showsIndicators: true) {
                            
                            HStack(spacing: 15) {
                                ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                                    SampleCustomExam()

                                }
                            }
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .scrollTargetLayout()
                        .contentMargins(20, for: .scrollContent)
                        
                        
                        //Spacer()
                        
                    }
                    .frame(maxWidth: .infinity).padding(.all, 20.0)
                    .frame(height: 300.0)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 10)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    TextField("Enter text here", text: $userRequest, axis: .vertical)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5...30)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .padding(.top, 20)
                        .padding(.horizontal)
                    
                }
                .padding(.vertical)
                
            }
        }
        .background(
            Image("Logo")
                .offset(x: -280, y: -60)
            
        )
        .preferredColorScheme(.dark)
        .onAppear {
            //UserDefaultsManager.resetAllValues()
        }
        
    }
    
    // MARK: - Subviews
    private var promptSuggestionsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.samplePrompts, id: \.self) { prompt in
                    Text(prompt)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.5)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: 150, height: 30)
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .cornerRadius(10)
                        .onTapGesture {
                            // viewModel.handleRequest(prompt)
                        }
                }
            }
            .frame(height: 110)
            .padding(.horizontal)
        }
    }
    
    
    private var inputAndActionButtonView: some View {
        HStack {
            if isExpanded {
                Button(action: {}) {
                    Image(systemName: "folder")
                        .foregroundColor(.teal)
                        .frame(width: 20, height: 20)
                }
                Button(action: {}) {
                    Image(systemName: "photo")
                        .foregroundColor(.teal)
                        .frame(width: 20, height: 20)
                }
            }
            Button(action: { isExpanded.toggle() }) {
                Image(systemName: "plus")
                    .foregroundColor(.teal)
                    .frame(width: 20, height: 20)
            }
            textFieldView
            micButtonView
        }
        .padding()
        .padding(.vertical)
        .padding(.bottom, 15)
    }
    
    private var textFieldView: some View {
        TextField("", text: $userRequest, prompt: Text("Type a message").foregroundColor(.white.opacity(0.3)), axis: .vertical)
            .lineLimit(2...10)
            .foregroundStyle(.white)
            .frame(height: userRequest.isEmpty ? 20 : nil)
            .padding(.vertical, userRequest.isEmpty ? 0 : 10)
            .cornerRadius(10)
            .background(.ultraThinMaterial)
            .onSubmit {
                
            }
            .onTapGesture {
                isExpanded = false
            }
    }
    
    private var micButtonView: some View {
        Button(action: { /* Mic functionality */ }) {
            Image(systemName: userRequest.isEmptyOrWhiteSpace ? "mic" : "arrow.up")
                .foregroundColor(.teal)
                .frame(width: 20, height: 20)
        }
    }
}

#Preview {
    AiAssistant()
}
