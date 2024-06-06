//
//  VoiceRecorderService .swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 05/06/2024.
//

import Foundation
import AVFoundation
import Combine
/// Recording Voice Message
/// Storing Message URL
final class VoiceRecorderService {
    private var audioRecorder: AVAudioRecorder?
    @Published private(set) var isRecording = false
    @Published private(set) var elapsedTime: TimeInterval = 0
    private var startTime: Date?
    private var timer: AnyCancellable?
    
    deinit{
        tearDown()
        print("VoiceRecorderService has been deinited")
    }

    func startRecording() {
        // Set up Audio Session
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.overrideOutputAudioPort(.speaker)
            try audioSession.setActive(true)
            print("VoiceRecorderService: Sucessfully set up AVAudioSession")
        } catch {
            print("VoiceRecorderService: Failed to set up AVAudioSession")
        }

        
        // Where do you want to store the voice message? URL
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFileName = Date().toString(format: "dd-MM-YY 'at' HH:mm:ss") + ".m4a"
        let audioFileURL = documentPath.appendingPathComponent(audioFileName)

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ] 

        do {
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder?.record()
            isRecording = true
            startTime = Date()
            startTimer()
            print("VoiceRecorderService: Sucessfully set up AVAudioSession")
        } catch {
            print("VoiceRecorderService: Failed to set up AVAudioRecorder")
        }
    }

    func stopRecording(completion: ((_ audioURL: URL?, _ audioDuration: TimeInterval) -> Void)? = nil) {
        guard isRecording else { return }
        let audioDuration = elapsedTime
        audioRecorder?.stop()
        isRecording = false
        timer?.cancel()
        elapsedTime = 0

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
            guard let audioURL = audioRecorder?.url else { return }
            completion?(audioURL, audioDuration)
        } catch {
            print("VoiceRecorderService: Failed to teardown AVAudioSession")
        }
    }
    
    func tearDown() {
        if isRecording {stopRecording()}
        let fileManager = FileManager.default
        let folder = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let folderContents = try! fileManager.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil)
        deleteRecordings(folderContents)
        print("VoiceRecorderService: was successfully teared down")
    }

    private func deleteRecordings(_ urls: [URL]) {
        for url in urls {
            deleteRecording(at: url)
        }
    }

    func deleteRecording(at fileURL: URL) {
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("Audio File was deleted at \(fileURL)")
        } catch {
            print("Failed to delete File")
        }
    }


    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let startTime = self?.startTime else { return }
                self?.elapsedTime = Date().timeIntervalSince(startTime)
                print("VoiceRecorderService: elapsedTime: \(String(describing: self?.elapsedTime))")
            }
    }

}

