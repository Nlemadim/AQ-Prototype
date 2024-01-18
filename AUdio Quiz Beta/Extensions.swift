//
//  Extensions.swift
//  Exam Genius Audio Quiz Player
//
//  Created by Tony Nlemadim on 1/18/24.
//

import Foundation
import SwiftUI

extension View {
    var deviceCornerRadius: CGFloat {
        let key = "_displayCornerRadius"
        if let screen = (UIApplication.shared.connectedScenes.first as?
            UIWindowScene)?.windows.first?.screen {
            if let cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
            
            return 0
        }
        
        return 0
    }
}

extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func activeGlow(_ color: Color, radius: CGFloat) -> some View {
        self
            .shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
    }
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func labelStyle() -> some View {
        self
            .font(.system(size: 18))
            .fontWeight(.semibold)
            .foregroundStyle(.white)
    }
    
    func scoreStyle() -> some View {
        self
            .foregroundStyle(.themePurple)
            .font(.system(size: 18))
            .fontWeight(.bold)
    }
    
    func backgroundStyle() -> some View {
        self
            .padding()
            .background(Color.gray.opacity(0.06))
    }
}

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Image {
    func iconStyle() -> some View {
        self
            .resizable()
            .frame(width: 25, height: 20)
            .foregroundColor(Color.orange) // Changed to foregroundColor
    }
}

