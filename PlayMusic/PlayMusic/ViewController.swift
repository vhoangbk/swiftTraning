//
//  ViewController.swift
//  PlayMusic
//
//  Created by Hoang Nguyen on 7/30/16.
//  Copyright © 2016 Hoang Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var playerItem : AVPlayerItem?
    var player : AVPlayer?
    
    var timer : NSTimer?

    @IBOutlet var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let path = NSBundle.mainBundle().pathForResource("Nova", ofType: "mp3");
        let url = NSURL(fileURLWithPath: path!);
        
        playerItem = AVPlayerItem(URL: url);
        player = AVPlayer(playerItem: playerItem!);
        
        playerItem?.addObserver(self, forKeyPath: "status", options: .New, context: nil);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(sender: AnyObject) {
        if playerItem?.status == .ReadyToPlay {
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.playerDidFinish), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
            
            player?.play();
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.updateSider), userInfo: nil, repeats: true);
            
        }
        
    }
    
    func playerDidFinish() {
        timer?.invalidate();
        slider.value = 0;
        playerItem?.seekToTime(kCMTimeZero);
    }

    @IBAction func pause(sender: AnyObject) {
        player?.pause();
        timer?.invalidate();
    }
    @IBAction func stop(sender: AnyObject) {
        playerItem?.seekToTime(kCMTimeZero);
        player?.pause();
        timer?.invalidate();
        slider.value = 0;
    }
    
    func updateSider() {
        let currentTime = CMTimeGetSeconds((playerItem?.currentTime())!);
        
        slider.value = Float(currentTime);
    }
    
    
    @IBAction func seek(sender: AnyObject) {
        playerItem?.seekToTime(CMTimeMake(Int64(slider.value), 1));
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (keyPath! == "status") {
            if (playerItem?.status == AVPlayerItemStatus.ReadyToPlay) {
                let duration = CMTimeGetSeconds((playerItem?.duration)!);
                slider.maximumValue = Float(duration);
            }
            
        }
    }
    
}

