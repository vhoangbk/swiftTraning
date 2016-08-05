//
//  ViewController.swift
//  GenerateBarcode
//
//  Created by paraline on 8/2/16.
//  Copyright © 2016 paraline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var tfInput: UITextField!
	@IBOutlet var imageDisplay: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@IBAction func genarateBarcode(sender: AnyObject) {
		imageDisplay.image = generateBarcodeFromString(tfInput.text!)
	}

	@IBAction func generateQrcode(sender: AnyObject) {
		imageDisplay.image = generateQrcodeFromString(tfInput.text!)
	}
	
	func generateBarcodeFromString(string : String) -> UIImage? {
		let data = string.dataUsingEncoding(NSASCIIStringEncoding)
		let filter = CIFilter(name: "CICode128BarcodeGenerator")
		
		filter?.setValue(data, forKey: "inputMessage")
		let transform = CGAffineTransformMakeScale(10, 10)
		
		let output = filter?.outputImage?.imageByApplyingTransform(transform)
		if (output != nil) {
			return UIImage(CIImage: output!)
		}
		return nil;
		
	}
	
	
	func generateQrcodeFromString(string : String) -> UIImage? {
		let data = string.dataUsingEncoding(NSASCIIStringEncoding)
		let filter = CIFilter(name: "CIQRCodeGenerator")
		
		filter?.setValue(data, forKey: "inputMessage")
		let transform = CGAffineTransformMakeScale(10, 10)
		
		let output = filter?.outputImage?.imageByApplyingTransform(transform)
		if (output != nil) {
			return UIImage(CIImage: output!)
		}
		return nil;
	}
	
}

