//
//  ViewController.swift
//  StopWatch
//
//  Created by Hoang Nguyen on 7/18/16.
//  Copyright © 2016 Hoang Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lbDisplay: UILabel!
    var countTime : UInt64 = 0;
    var timer = NSTimer();
    var isRuning = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressStart(sender: AnyObject) {
        if (!isRuning) {
            isRuning = true
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(timerHanler), userInfo: nil, repeats: true)
        }
        
    }

    @IBAction func pressPause(sender: AnyObject) {
        timer.invalidate();
        isRuning = false;
    }
    

    @IBAction func pressStop(sender: AnyObject) {
        timer.invalidate();
        countTime = 0;
        isRuning = false;
    }
    
    func timerHanler(){
        countTime += 1;
        print(countTime);
    }
}

