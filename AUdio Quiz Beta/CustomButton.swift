//
//  CustomButton.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import Foundation
import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black) // Text color
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("OrangeLight")) // Custom color
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BG"), lineWidth: 1)
                )
        }
        .padding(.top)
        
    }
}

