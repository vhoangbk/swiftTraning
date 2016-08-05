//
//  ViewController.swift
//  LessAndBigger
//
//  Created by paraline on 8/5/16.
//  Copyright © 2016 paraline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbLeft: UILabel!
    @IBOutlet weak var lbRight: UILabel!
	@IBOutlet var lbScore: UILabel!
	@IBOutlet var lbQuestion: UILabel!
	@IBOutlet var btnLeft: UIButton!
	@IBOutlet var btnRight: UIButton!
    
    let maxNumber = 10;
    var currentNumber = 0;
	
	var score = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initQuestion();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func less(sender: AnyObject) {
		if (currentNumber < maxNumber) {
			if (Int(lbLeft.text!)! < Int(lbRight.text!)!) {
				score += 10;
				lbScore.text = String(score);
			}
			currentNumber += 1;
			initQuestion();
			
		}
		
    }
 
    @IBAction func bigger(sender: AnyObject) {
		if (currentNumber < maxNumber) {
			if (Int(lbLeft.text!)! > Int(lbRight.text!)!) {
				score += 10;
				lbScore.text = String(score);
			}
			currentNumber += 1;
			initQuestion();
		}

    }

    func ramdomNumber() -> Int {
		return Int(arc4random_uniform(100));
    }
    
    func initQuestion() {
        if (currentNumber == maxNumber) {
			btnLeft.enabled = false;
			btnRight.enabled = false;
            return
        }
		lbQuestion.text = "\(currentNumber+1)/\(maxNumber)"
        let numLeft = ramdomNumber();
		var numRight = ramdomNumber();
		
		while (numLeft == numRight) {
			numRight = ramdomNumber();
		}
        
        lbLeft.text = String(numLeft);
		lbRight.text = String(numRight);
    }
	
	@IBAction func again(sender: AnyObject) {
		score = 0;
		currentNumber = 0;
		lbScore.text = String(score)
		btnLeft.enabled = true;
		btnRight.enabled = true;
		initQuestion();
	}
}

