//
//  VoiceSearchInstructionView.swift
//  CoreDataDemo
//
//  Created by Bhavik Barot on 11/03/19.
//  Copyright © 2019 Bhavik Barot. All rights reserved.
//

import UIKit
import Speech

protocol VoiceSearchInstructionViewDelegate: class {
    func didReciveTextFromSpeech(_ voiceText: String)
    func voiceSearchInstructionViewDissmiss()
}

class VoiceSearchInstructionView: UIView {
    
    @IBOutlet weak var vwSpeechInstruction: UIView!
    @IBOutlet weak var lblSpeechInstruction: UILabel!
    @IBOutlet weak var btnMicrophone: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    var delegate: VoiceSearchInstructionViewDelegate?
    
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    var speechSynthesizer = AVSpeechSynthesizer()
    
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    
    private var userSearchStr: String! = ""
    
//    override func awakeFromNib() {
//        self.vwSpeechInstruction.layer.cornerRadius = 10
//        self.setupMicrophone()
//        self.speechSynthesizer.delegate = self
//        self.speechSynthesizer.stopSpeaking(at: .immediate)
//        self.btnMicrophone.addTarget(self, action: #selector(microphoneTapped(_:)), for: .touchUpInside)
//        self.btnClose.addTarget(self, action: #selector(btnCloseTapped(_:)), for: .touchUpInside)
//    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.vwSpeechInstruction.layer.cornerRadius = 10
        self.setupMicrophone()
        self.speechSynthesizer.delegate = self
        self.speechSynthesizer.stopSpeaking(at: .immediate)
        self.btnMicrophone.addTarget(self, action: #selector(microphoneTapped(_:)), for: .touchUpInside)
        self.btnClose.addTarget(self, action: #selector(btnCloseTapped(_:)), for: .touchUpInside)
    }
}
//MARK:- SpeechToText Methods
extension VoiceSearchInstructionView: SFSpeechRecognizerDelegate, AVSpeechSynthesizerDelegate {
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            btnMicrophone.isEnabled = true
            btnMicrophone.alpha = 1.0
        } else {
            btnMicrophone.isEnabled = false
            btnMicrophone.alpha = 0.40
        }
    }
    
    func setupMicrophone() {
        btnMicrophone.isEnabled = false
        speechRecognizer.delegate = self
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            var isButtonEnabled = false
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.btnMicrophone.isEnabled = isButtonEnabled
            }
        }
    }
    
    @objc func microphoneTapped(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                try audioSession.setMode(AVAudioSession.Mode.default)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            } catch {
                print("audioSession properties weren't set because of an error.")
            }
            
            btnMicrophone.isEnabled = false
            btnMicrophone.setTitle("Start Recording", for: .normal)
            if self.delegate != nil {
                self.delegate?.didReciveTextFromSpeech(self.userSearchStr)
            }
        } else {
            startRecording()
            btnMicrophone.setTitle("Search Recording", for: .normal)
        }
    }
    
    @objc func btnCloseTapped(_ sender: UIButton) {
        if self.delegate != nil {
            self.delegate?.voiceSearchInstructionViewDissmiss()
        }
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
//            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                debugPrint(result?.bestTranscription.segments as Any)
                self.userSearchStr = (result?.bestTranscription.formattedString)!
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.btnMicrophone.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            debugPrint(buffer)
            self.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
}
