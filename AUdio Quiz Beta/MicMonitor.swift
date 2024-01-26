//
//  MicMonitor.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/22/24.
//

//import Foundation
//import AVFoundation
//import SwiftUI
//
//class MicMonitor: ObservableObject {
//    private var audioRecorder: AVAudioRecorder
//    private var timer: Timer?
//    
//    private var currentSample: Int
//    private let numberOfSamples: Int
//    
//    @Published public var soundSamples: [Float]
//    
//    init(numberOfSamples: Int) {
//        self.numberOfSamples = numberOfSamples > 0 ? numberOfSamples : 10
//        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
//        self.currentSample = 0
//        
//        let audioSession = AVAudioSession.sharedInstance()
//        if audioSession.recordPermission != .granted {
//            audioSession.requestRecordPermission { (success) in
//                if !success {
////                    DispatchQueue.main.async {
////                        let alert = UIAlertController(title: "Permission Denied", message: "Quiz Player needs access to mic. You can change your permission settings in the Privacy & Security section of the Settings app.", preferredStyle: .alert)
////                        alert.addAction(UIAlertAction(title: "OK", style: .default))
////                        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
////                        
////                    }
//                }
//            }
//        }
//        
//        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
//        let recorderSettings: [String: Any] = [
//            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
//            AVSampleRateKey: 44100.0,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
//        ]
//        
//        do {
//            audioRecorder = try AVAudioRecorder(url: url, settings: recorderSettings)
//            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
//        } catch {
//            fatalError(error.localizedDescription)
//        }
//    }
//    
//
//    
//    public func startMonitoring() {
//        audioRecorder.isMeteringEnabled = true
//        audioRecorder.record()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
//            self.audioRecorder.updateMeters()
//            self.soundSamples[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
//            self.currentSample  = (self.currentSample + 1) % self.numberOfSamples
//        })
//    }
//    
//    public func stopMonitoring() {
//        audioRecorder.stop()
//    }
//    
//    deinit {
//        timer?.invalidate()
//        audioRecorder.stop()
//    }
//    
//    func requestPermissions() async {
//        let permission = await AVAudioApplication.requestRecordPermission()
//        // Request permission to record.
//        // The user grants access. Present recording interface.
//        if !permission {
//
//            DispatchQueue.main.async {
//                let alert = UIAlertController(title: "Permission Denied", message: "Quiz Player needs access to mic. You can change your permission settings in the Privacy & Security section of the Settings app.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default))
//                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
//                
//            }
//        }
//    }
//}
