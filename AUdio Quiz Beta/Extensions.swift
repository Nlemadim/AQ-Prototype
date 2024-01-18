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
