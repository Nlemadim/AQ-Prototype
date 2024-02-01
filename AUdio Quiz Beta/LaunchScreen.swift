//
//  LaunchScreen.swift
//  Exam Genius Audio Quiz Player
//
//  Created by Tony Nlemadim on 1/15/24.
//(colors: [.themePurple, .purple.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 280, alignment: .center)
                    .padding(.bottom, 30)
                Text("Audio Quiz")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.themePurple)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                .teal.gradient
            )
        }
    }
}

#Preview {
    LaunchScreen()
}
