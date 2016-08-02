//
//  ViewController.swift
//  Recoder
//
//  Created by paraline on 8/2/16.
//  Copyright © 2016 paraline. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    var isAllowed : Bool = false;
    var isRecording : Bool = false;
    
    var path : String?;
    let fileName : String = "record.m4a";

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        path = paths[0]
        
        
        recordingSession = AVAudioSession.sharedInstance();
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            
            try recordingSession.setActive(true)
            
            recordingSession.requestRecordPermission({ (allowed : Bool) in
                self.isAllowed = allowed;
            })

        } catch {
            // failed to record!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func record(sender: AnyObject) {
        
        if (isAllowed == false || isRecording == true) {
            return;
        }
        
        let audioURL = NSURL(fileURLWithPath: path!).URLByAppendingPathComponent(fileName)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(URL: audioURL, settings: settings);
            audioRecorder.record()
            isRecording = true;
            
        } catch {
            
        }
    }

    @IBAction func stop(sender: AnyObject) {
        isRecording = false;
        audioRecorder.stop();
        audioRecorder = nil;
    }
    
    @IBAction func play(sender: AnyObject) {
        
        let audioURL = NSURL(fileURLWithPath: path!).URLByAppendingPathComponent(fileName);
        
        do{
            let audioPlayer = try AVAudioPlayer(contentsOfURL: audioURL);
            audioPlayer.play();
        } catch{
            print("play error")
        }
        
    }
}

