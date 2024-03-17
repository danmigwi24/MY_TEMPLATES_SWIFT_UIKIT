//
//  SpeechLearningSwiftUIView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 22/02/2024.
//

import Foundation
import SwiftUI
import MBCore
import Speech
import AVFoundation

struct SpeechLearningSwiftUIView1: View {
    @State private var recognizedText = ""
    @State private var isRecording = false
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private let audioEngine = AVAudioEngine()
    
    var body: some View {
        VStack {
            Text(recognizedText)
                .padding()
            Button(action: {
                self.isRecording.toggle()
                self.isRecording ? startRecording() : stopRecording()
            }) {
                Text(isRecording ? "Stop Recording" : "Start Recording")
                    .padding()
            }
        }
    }
    
    func startRecording() {
        guard !isRecording else { return }
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .default)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session properties weren't set because of an error.")
        }
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode
        request.shouldReportPartialResults = true
        
        let recognitionTask = speechRecognizer.recognitionTask(with: request) { result, error in
            guard let result = result else {
                print("Recognition failed: \(error ?? "No error" as! Error)")
                return
            }
            
            if result.isFinal {
                self.recognizedText = result.bestTranscription.formattedString
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("Audio engine couldn't start because of an error.")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
}



/**
 METHOD TWO
 */

struct SpeechLearningSwiftUIView: View {
    @State private var recognizedText = ""
    @State private var isRecording = false
    @State private var isPlaying = false
    @State private var audioPlayer: AVAudioPlayer?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private let audioEngine = AVAudioEngine()
    private let audioSession = AVAudioSession.sharedInstance()
    private var audioFileURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("recordedAudio.wav")
    }
    
    var body: some View {
        VStack {
            Text(recognizedText)
                .padding()
            
            Button(action: {
                if self.isRecording {
                    self.stopRecording()
                    self.isRecording.toggle()
                } else {
                    self.startRecording()
                    self.isRecording.toggle()
                }
            }) {
                Text(isRecording ? "Stop Recording" : "Start Recording")
                    .padding()
            }
            
            Button(action: {
                if let url = try? self.audioFileURL {
                    self.playAudio(url: url)
                    print("audio found")
                }else{
                    print("no audio")
                }
            }) {
                Text("Play Recorded Audio")
                    .padding()
            }
        }
    }
    
    func startRecording() {
        do {
            try audioSession.setCategory(.record, mode: .default)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session properties weren't set because of an error.")
        }
        
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            try? self.recordAudio(buffer: buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("Audio engine couldn't start because of an error.")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    func recordAudio(buffer: AVAudioPCMBuffer) throws {
        let audioFile = try AVAudioFile(forWriting: audioFileURL, settings: buffer.format.settings)
        try audioFile.write(from: buffer)
    }
    
    func playAudio(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}




/**
 METHOD THREE
 */


