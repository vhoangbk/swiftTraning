//
//  ViewController.swift
//  PlayVideo
//
//  Created by paraline on 8/1/16.
//  Copyright © 2016 paraline. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    let movieLink : String = "http://channelz2.mp3.zdn.vn/zv/abb5bbe33a72c614c97c1a1c52ceb9e1/579ff090/2016/07/19/0/f/0f76cbc7213d033938e0d1364c30dd64.mp4"
    
    var moviePlayer : AVPlayer?;
    
    var moviePlayerVC : AVPlayerViewController?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url : NSURL = NSURL(string: movieLink)!
        moviePlayer = AVPlayer(URL: url);
        moviePlayerVC = AVPlayerViewController();
        moviePlayerVC?.player = moviePlayer;        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func play(sender: AnyObject) {
        presentViewController(moviePlayerVC!, animated: true, completion: {
            self.moviePlayer?.play();
        });
    }
}

