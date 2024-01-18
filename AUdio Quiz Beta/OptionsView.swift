//
//  OptionsView.swift
//  ExamGenius
//
//  Created by Tony Nlemadim on 12/14/23.
//

import SwiftUI

struct OptionsView: View {
    let option: String
    var tint: Color
    var isCorrect: Bool? = false
    var explanation: String? = ""
    var action: () -> Void
    @State private var showExplanationModal: Bool = false

    var body: some View {
        Button(action: {
            if UserDefaultsManager.isStudyModeEnabled() {
                if let isCorrect = isCorrect, !isCorrect {
                    print("Incorrect answer selected, showing explanation modal.")
                    showExplanationModal = true
                } else {
                    
                    action() //TODO: eg: Change the tint color of selected option and change to next option
                }
            } else {
                action() // TODO: eg: Change the tint color of selected option
            }
        }) {
            Text(option)
                .foregroundStyle(.black.opacity(0.7))
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .hAlign(.leading)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(tint.opacity(0.15))
                        .background {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(tint.opacity(tint == .black ? 0.15 : 1), lineWidth: 2)
                        }
                }
        }
        .sheet(isPresented: $showExplanationModal) {
            if let explanation = explanation {
                IncorrectAnswerModal(explanation: explanation)
            }
        }
        

//        Button(action: {
//           
//            
//        } {
//            Text(option)
//                .foregroundStyle(.black.opacity(0.7))
//                .padding(.horizontal, 15)
//                .padding(.vertical, 20)
//                .hAlign(.leading)
//                .background {
//                    RoundedRectangle(cornerRadius: 12, style: .continuous)
//                        .fill(tint.opacity(0.15))
//                        .background {
//                            RoundedRectangle(cornerRadius: 12, style: .continuous)
//                                .stroke(tint.opacity(tint == .black ? 0.15 : 1), lineWidth: 2)
//                        }
//                }
//        }
//        .sheet(isPresented: $showExplanationModal) {
//            if let explanation = explanation {
//                IncorrectAnswerModal(explanation: explanation)
//            }
//        }
    }
}

struct IncorrectAnswerModal: View {
    let explanation: String

    var body: some View {
        VStack {
            Text("Incorrect Answer")
                .font(.headline)
                .foregroundColor(.red)
            Text(explanation)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

