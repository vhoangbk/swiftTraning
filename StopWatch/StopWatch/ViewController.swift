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
    var timer = NSTimer();
    var isRuning = false;
    var hour : Int = 0;
    var minute : Int = 0;
    var second : Int = 0;
    var minSecond : Int = 0;
    
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
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(timerHanler), userInfo: nil, repeats: true)
        }
        
    }

    @IBAction func pressPause(sender: AnyObject) {
        timer.invalidate();
        isRuning = false;
    }
    

    @IBAction func pressStop(sender: AnyObject) {
        timer.invalidate();
        hour = 0;
        minute = 0;
        second = 0;
        minSecond = 0;
        isRuning = false;
        
        lbDisplay.text = convertNumber2Text(hour) + ":" + convertNumber2Text(minute) + ":" + convertNumber2Text(second) + "." + convertNumber2Text(minSecond);
    }
    
    func timerHanler(){
        minSecond += 1;
        print(minSecond);
        if (minSecond == 100) {
            minSecond = 0;
            second += 1;
        }
        if (second == 60) {
            second = 0;
            minute += 1;
        }
        if (minute == 60) {
            hour += 1;
        }
        
        lbDisplay.text = convertNumber2Text(hour) + ":" + convertNumber2Text(minute) + ":" + convertNumber2Text(second) + "." + convertNumber2Text(minSecond);
    }
    
    func convertNumber2Text(number : Int) -> String {
        var resutl : String = String(number);
        if (number < 10) {
            resutl = "0" + resutl;
        }
        return resutl;
    }
}

