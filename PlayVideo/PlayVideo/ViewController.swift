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
    
    let movieLink : String = "http://channelz2.mp3.zdn.vn/zv/1235ce4ffaebab11711d49a1e588fc42/579f0f90/2014/01/16/c/2/c23b1970ed9006b0ad67f81c8e22ead9.mp4"
    
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

