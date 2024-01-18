//
//  PlayerContentInfo.swift
//  Exam Genius Audio Quiz Player
//
//  Created by Tony Nlemadim on 1/15/24.
//

import Foundation
import SwiftUI

struct PlayerContentInfo: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    var body: some View {
        HStack(spacing: 0) {
            
            ZStack {
                if !expandSheet {
                    GeometryReader {
                        let size = $0.size

                        Image("IconImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: expandSheet ? 15 : 5, style: .continuous))
                    }
                }
            }
            .frame(width: 45, height: 45)
          
            
            Text("Exam Genius Audio Quiz Player")
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal, 15)
            
            Button {
                
            } label: {
                Image(systemName: "pause.fill")
                    .font(.title2)
            }
            
            Button {
                
            } label: {
                Image(systemName: "forward.fill")
                    .font(.title2)
            }
            .padding(.leading, 25)
        }
        .foregroundStyle(.primary)
        .padding(.horizontal)
        .padding(.bottom, 5)
        .frame(height: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                expandSheet = true
            }
        }
    }
}
