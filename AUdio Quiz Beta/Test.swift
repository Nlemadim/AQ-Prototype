//
//  Test.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/24/24.
//

import SwiftUI

struct Test: View {
    @StateObject var speechRecognizer = SpeechManager()
    @State private var isRecording = false
    @State private var transcriptCopy: String = ""
    
    var body: some View {
        VStack {
            Text("Awaiting Transcription")
                //.opacity(speechRecognizer.transcript.isEmpty ? 1 : 0)
            
            Text(speechRecognizer.transcript)
                .padding()
            
            Button(action: {
                if !isRecording {
                    speechRecognizer.transcribe()
                    self.transcriptCopy = speechRecognizer.transcript
                    print(transcriptCopy)
                } else {
                    speechRecognizer.stopTranscribing()
                }
                
                isRecording.toggle()
            }) {
                Text(isRecording ? "Stop" : "Record")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(isRecording ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    Test()
}
