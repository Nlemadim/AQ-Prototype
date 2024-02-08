//
//  MiniPlayerControls.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/31/24.
//

import SwiftUI

struct QuizControlConfiguration {
    let selectA: () -> Void
    let selectB: () -> Void
    let selectC: () -> Void
    let selectD: () -> Void
    let selectPlay: () -> Void
    let selectReplay: () -> Void
    let selectNext: () -> Void
}





//#Preview {
//    RecordAndOptionsButton3(recordAction: {})
//}


struct AbcdButtons: View {
    @Binding var open: Bool
    var label: String
    var color: Color
    var offsetX: CGFloat
    var offsetY: CGFloat
    var delay: Double
    var body: some View {
        Button(action: {}, label: {
            Text(label)
                .foregroundStyle(.black)
                .font(.system(size: 16, weight: .bold))
                .padding(.horizontal)
        })
        .padding()
        .background(color)
        .mask(RoundedRectangle(cornerRadius: 10).frame(width: 40, height: 25))
        .offset(x: open ? offsetX : 0, y: open ? offsetY : 0)
        .scaleEffect(open ? 1 : 0)
        //.animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(delay))
    }
}

struct RecordAndOptionsButton3: View {
    @State private var fillAmount: CGFloat = 0.0
    @State var open: Bool = false
    @State private var micInUse: Bool = false
    @State private var showProgressRing: Bool = false
    let imageSize: CGFloat = 20
    var recordAction: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
//            // Reduced spacing to 1 point between buttons for a tighter layout
//            let spacing: CGFloat = 0
//            let buttonWidth: CGFloat = 7 // Adjust if your button width is different
//            
//            // Offsets for the left-side and right-side buttons
//            let offsetsLeft = calculateOffsets(for: ["A", "B"], spacing: spacing, buttonWidth: buttonWidth, imageSize: imageSize)
//            let offsetsRight = calculateOffsets(for: ["C", "D"], spacing: spacing, buttonWidth: buttonWidth, imageSize: imageSize, leftSide: false)
//            
//            // Left buttons
//            ForEach(0..<2) { index in
//                PopOutOptionsButton2(
//                    open: $open,
//                    label: ["A", "B"][index],
//                    color: .teal,
//                    offsetX: open ? offsetsLeft[index] : 0,
//                    offsetY: 0,
//                    delay: 0.1 * Double(index)
//                )
//            }
            
            
            ZStack {
                if showProgressRing {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 3)
                        .frame(width: imageSize * 3, height: imageSize * 3)
                        .opacity(micInUse ? 1 : 0)
                    
                    Circle()
                        .trim(from: 0, to: fillAmount)
                        .stroke(Color.red, lineWidth: 5)
                        .frame(width: imageSize * 3, height: imageSize * 3)
                        .rotationEffect(.degrees(-180))
                        .animation(.linear(duration: 5), value: fillAmount)
                        .shadow(color: .teal, radius: 10)
                }
                
                // Mic button action
                Button(action: {
                    self.open.toggle()
                    micInUse.toggle()
                    if micInUse {
                        self.startFilling()
                    }
                }) {
                    Image(systemName: micInUse ? "mic.fill" : "mic.slash")
                        .font(.system(size: imageSize))
                        .foregroundColor(micInUse ? .red : .black.opacity(0.6))
                }
                .padding(18)
                .background(.teal)
                .mask(Circle())
                .shadow(color: .teal, radius: 10)
                .zIndex(10)
            }
            
//            // Right buttons
//            ForEach(2..<4) { index in
//                PopOutOptionsButton2(
//                    open: $open,
//                    label: ["C", "D"][index - 2],
//                    color: .teal,
//                    offsetX: open ? offsetsRight[index - 2] : 0,
//                    offsetY: 0,
//                    delay: 0.1 * Double(index - 2)
//                )
//            }
        }
       // .frame(maxWidth: .infinity)
        .preferredColorScheme(.dark)
        .padding(.horizontal)
    }
    
    private func calculateOffsets(for labels: [String], spacing: CGFloat, buttonWidth: CGFloat, imageSize: CGFloat, leftSide: Bool = true) -> [CGFloat] {
        var offsets = [CGFloat]()
        for (index, _) in labels.enumerated() {
            let offset = CGFloat(index + 1) * (buttonWidth + spacing)
            offsets.append(leftSide ? -offset : offset)
        }
        return offsets
    }
    
//    private func calculateOffsets(for labels: [String], spacing: CGFloat, buttonWidth: CGFloat, imageSize: CGFloat, leftSide: Bool = true) -> [CGFloat] {
//        var offsets = [CGFloat]()
//        let totalSpacing = spacing * CGFloat(labels.count - 1) // Total spacing between buttons
//        let totalWidth = buttonWidth * CGFloat(labels.count) // Total width of buttons
//        let startingOffset = imageSize / 2 + buttonWidth / 2 // Offset from the center of the record button
//
//        for (index, _) in labels.enumerated() {
//            let offset = startingOffset + totalWidth + totalSpacing - CGFloat(index) * (buttonWidth + spacing)
//            offsets.append(leftSide ? -offset : offset)
//        }
//        return offsets
//    }

    
    private func startFilling() {
        fillAmount = 0.0 // Reset the fill amount
        showProgressRing = true // Show the progress ring
        withAnimation(.linear(duration: 5)) {
            fillAmount = 1.0 // Fill the ring over 5 seconds
        }
        // Hide the progress ring after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showProgressRing = false
        }
    }
}

// Your PopOutOptionsButton2 struct implementation goes here


struct PopOutOptionsButton: View {
    @Binding var open: Bool
    var label = "A"
    var color = Color(.teal)
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0
    var body: some View {
        Button(action: {}, label: {
            Text(label)
                .foregroundStyle(.black)
                .font(.headline)
            //.font(.system(size: 10, weight: .bold))
                .padding(.horizontal)
        })
        .padding()
        .background((color))
        //.mask(RoundedRectangle(cornerRadius: 10).frame(width: 30, height: 30))
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1 : 0)
        //        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)))
        
    }
}

struct PopOutOptionsButton2: View {
    @Binding var open: Bool
    var label: String
    var color: Color
    var offsetX: CGFloat
    var offsetY: CGFloat
    var delay: Double
    var body: some View {
        Button(action: {}, label: {
            Text(label)
                .foregroundStyle(.black)
                .font(.system(size: 16, weight: .bold))
                .padding(.horizontal)
        })
        .padding()
        .background(color)
        .mask(RoundedRectangle(cornerRadius: 10).frame(width: 40, height: 25))
        .offset(x: open ? offsetX : 0, y: open ? offsetY : 0)
        .scaleEffect(open ? 1 : 0)
        //.animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(delay))
    }
}


struct RecordAndOptionsButton2: View {
    @State private var fillAmount: CGFloat = 0.0
    @State private var micInUse: Bool = false
    @State private var showProgressRing: Bool = false
    let imageSize: CGFloat = 12
    var recordAction: () -> Void
    
    var body: some View {
            
            ZStack {
                
                if showProgressRing {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 5)
                        .frame(width: imageSize * 2, height: imageSize * 2)
                        .opacity(micInUse ? 1 : 0)
                    
                    Circle()
                        .trim(from: 0, to: fillAmount)
                        .stroke(Color.red, lineWidth: 5)
                        .frame(width: imageSize * 2, height: imageSize * 2)
                        .rotationEffect(.degrees(-180))
                        .animation(.linear(duration: 5), value: fillAmount)
                        .shadow(color: .teal, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
                
                // Mic button action
                Button(action: {
                    micInUse.toggle()
                    if micInUse {
                        self.startFilling()
                    }
                }) {
                    Image(systemName: micInUse ? "mic.fill" : "mic.slash")
                        .font(.system(size: 18))
                        .foregroundColor(micInUse ? .red : .black.opacity(0.8))
                }
                .padding(24)
                .background(.teal)
                .mask(Circle())
                .shadow(color: .teal, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
  
            }
            .preferredColorScheme(.dark)
            
    }
    
    private func startFilling() {
        fillAmount = 0.0 // Reset the fill amount
        showProgressRing = true // Show the progress ring
        withAnimation(.linear(duration: 5)) {
            fillAmount = 1.0 // Fill the ring over 5 seconds
        }
        // Hide the progress ring after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showProgressRing = false
        }
    }
}
