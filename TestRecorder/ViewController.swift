//
//  ViewController.swift
//  TestRecorder
//
//  Created by Emma Williams on 27/07/2017.
//  Copyright © 2017 Emma Williams. All rights reserved.
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioStatus: AudioStatus = AudioStatus.stopped
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    //Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    // RECORDING CONTROLS
    @IBAction func onRecord(_ sender: Any) {
        if appHasMicAccess == true {
            if audioStatus != .playing {
                switch audioStatus {
                case .stopped:
                    record()
                case .recording:
                    recordButton.setTitle("Recording...", for: UIControlState())
                    stopRecording()
                default:
                    break
                }
            }
        } else {
            recordButton.isEnabled = false
        }
        
    }
    
    @IBAction func onPlay(_ sender: UIButton) {
    
        if audioStatus != .recording {
            
            switch audioStatus {
            case .stopped:
                play()
                playButton.setTitle("Playing...", for: UIControlState())

            case .playing:
                stopPlayback()
                playButton.setTitle("Play-Stopped", for: UIControlState())
            default:
                break
            }
        }
    }
}

//AV
extension ViewController: AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    //Recorder
    func setupRecorder() {
        let fileURL = getURLforMemo()
        
        let recordSettings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ] as [String : Any]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: recordSettings as [String : AnyObject])
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            print("error")
        }
    }
    
    func record() {
        audioRecorder.record()
        audioStatus = .recording
        recordButton.setTitle("Recording...", for: UIControlState())
        playButton.setTitle("ENABLED", for: UIControlState())

    }
    
    func stopRecording() {
        audioRecorder.stop()
        recordButton.setTitle("Rec-Stopped", for: UIControlState())
        audioStatus = .stopped
    }
    
    // Play
    func  play() {
        let fileURL = getURLforMemo()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer.delegate = self
            if audioPlayer.duration > 0.0 {
                audioPlayer.play()
                audioStatus = .playing
            }
        } catch {
            print("Error loading audioPlayer.")
        }
    }
    
    func stopPlayback() {
        audioPlayer.stop()
        audioStatus = .stopped
    }
    
    // Delegates
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        audioStatus = .stopped
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioStatus = .stopped
    }
    
    
    // Helpers
    
    func getURLforMemo() -> URL {
        let tempDir = NSTemporaryDirectory()
        let filePath = tempDir + "/TempMemo.caf"
        
        return URL(fileURLWithPath: filePath)
    }
    
    //TODO: Handle Interruptions
}


