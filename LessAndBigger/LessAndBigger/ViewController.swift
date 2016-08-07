//
//  ViewController.swift
//  LessAndBigger
//
//  Created by paraline on 8/5/16.
//  Copyright © 2016 paraline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var lbLeft: UILabel!
	@IBOutlet var lbRight: UILabel!
	@IBOutlet var btnLess: UIButton!
	@IBOutlet var btnBigger: UIButton!
    
	@IBOutlet var lbScore: UILabel!
	@IBOutlet var lbQuestion: UILabel!
	
	
	let maxQuestion = 10;
	var currentQuestion = 0;
	
	var score = 0;
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
		initQuestion();
    }
	
	func ramdomNumber() -> Int {
		//tra ve so ngau nhien tu 0 -> 99
		return Int(arc4random_uniform(100))
	}
	
	func initQuestion() {
		if (currentQuestion == maxQuestion) {
			btnLess.enabled = false;
			btnBigger.enabled = false;
			return;
		}
		let numberLeft = ramdomNumber();
		var numberRight = ramdomNumber();
		lbQuestion.text = "\(currentQuestion+1)/\(maxQuestion)";
		
		while (numberLeft == numberRight) {
			numberRight = ramdomNumber();
		}
		lbLeft.text = String(numberLeft);
		lbRight.text = String(numberRight);
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@IBAction func less(sender: AnyObject) {
		if (currentQuestion < maxQuestion) {
			if (Int(lbLeft.text!) < Int(lbRight.text!)) {
				score += 10;
				lbScore.text = String(score);
			}
			currentQuestion += 1;
			initQuestion();
		}
	}

	@IBAction func bigger(sender: AnyObject) {
		if (currentQuestion < maxQuestion) {
			if (Int(lbLeft.text!) > Int(lbRight.text!)) {
				score += 10;
				lbScore.text = String(score);
			}
			currentQuestion += 1;
			initQuestion();
		}
	}
	@IBAction func again(sender: AnyObject) {
		score = 0;
		lbScore.text = String(score);
		currentQuestion = 0;
		btnLess.enabled = true;
		btnBigger.enabled = true;
		initQuestion();
	}
}

