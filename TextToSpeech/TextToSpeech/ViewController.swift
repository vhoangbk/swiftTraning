//
//  ViewController.swift
//  TextToSpeech
//
//  Created by Hoang Nguyen on 8/7/16.
//  Copyright © 2016 Hoang Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

	@IBOutlet var tfText: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func speech(sender: AnyObject) {
		
		let utterance = AVSpeechUtterance(string: tfText.text!)
		utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
		utterance.rate = 0.5
		
		let synthesizer = AVSpeechSynthesizer()
		synthesizer.speakUtterance(utterance)
	}
}

