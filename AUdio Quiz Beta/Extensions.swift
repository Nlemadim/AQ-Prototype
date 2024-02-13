//
//  Extensions.swift
//  Exam Genius Audio Quiz Player
//
//  Created by Tony Nlemadim on 1/18/24.
//

import Foundation
import SwiftUI
import UIKit

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
    
    var isSingleCharacterABCD: Bool {
        return self.count == 1 && ["A", "B", "C", "D"].contains(self.uppercased())
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

extension UIImage {
    func dominantColor() -> UIColor? {
        // This is a placeholder for the actual implementation
        // You might use a more sophisticated algorithm to find the dominant color
        guard let inputImage = CIImage(image: self) else { return nil }
        let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: CIVector(cgRect: inputImage.extent)])
        guard let outputImage = filter?.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: 1)
        
        /// Use the dominant color for backgrounds
        //let image = UIImage(named: "yourImageName")!
        //.background(Color(image.dominantColor() ?? .gray)) // Fallback to gray if nil
    }
}

extension DownloadedAudioQuiz {
    func quizUIImage() -> UIImage? {
        // Assuming your quizImage names in the assets catalog match quizName or a predictable transformation of it
        let imageName = self.quizImage // Adjust if necessary
        return UIImage(named: imageName)
    }
}

//extension AudioQuiz {
//    func quizUIImage() -> UIImage? {
//        let imageName = quizImage.self.string value
//        // Assuming your quizImage names in the assets catalog match quizName or a predictable transformation of it
//        //let imageName = self.quizImage // Adjust if necessary
//        return UIImage(named: imageName)
//    }
//}



