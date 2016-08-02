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
    
	@IBOutlet var btnRecord: UIButton!
	@IBOutlet var btnStop: UIButton!
	@IBOutlet var btnPlay: UIButton!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    var path : String?;
    let fileName : String = "record.m4a";
	
	var audioPlayer : AVAudioPlayer?;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		btnRecord.enabled = false;
		btnStop.enabled = false;
		btnPlay.enabled = false
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        path = paths[0]
		
        recordingSession = AVAudioSession.sharedInstance();
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            
            try recordingSession.setActive(true)
            
            recordingSession.requestRecordPermission({ (allowed : Bool) in
			
				if (allowed){
					self.btnRecord.enabled = true;
					self.prepareRecode();
				}
				
            })

        } catch {
            // failed to record!
        }
    }
	
	func prepareRecode() {
		let audioURL = NSURL(fileURLWithPath: path!).URLByAppendingPathComponent(fileName)
			
		let settings = [
			AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
			AVSampleRateKey: 12000.0,
			AVNumberOfChannelsKey: 1 as NSNumber,
			AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
		]
		
		do {
			audioRecorder = try AVAudioRecorder(URL: audioURL, settings: settings);
			audioRecorder.prepareToRecord()
			
		} catch {
			print("audioRecorder error")
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func record(sender: AnyObject) {
		
		if (!audioRecorder.recording) {
			audioRecorder.record();
			
			btnRecord.enabled = false;
			btnStop.enabled = true;
		}

    }

    @IBAction func stop(sender: AnyObject) {
		if (audioRecorder.recording) {
			audioRecorder.stop();
			
			btnRecord.enabled = true;
			btnStop.enabled = false;
			btnPlay.enabled = true;
		}
    }
    
    @IBAction func play(sender: AnyObject) {
		let audioURL = NSURL(fileURLWithPath: path!).URLByAppendingPathComponent(fileName)
		
		do{
			try audioPlayer = AVAudioPlayer(contentsOfURL: audioURL);
		}catch{
			print("audioPlayer error")
		}
		self.audioPlayer?.play();
    }
}

