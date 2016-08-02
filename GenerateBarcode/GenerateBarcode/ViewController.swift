//
//  ViewController.swift
//  GenerateBarcode
//
//  Created by paraline on 8/2/16.
//  Copyright © 2016 paraline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgBarcode: UIImageView!
    @IBOutlet weak var tfText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func GenerateBarcode(sender: AnyObject) {
        let image = generateBarcodeFromString(tfText.text!);
        imgBarcode.image = image;
    }
    
    @IBAction func GenerateQrcode(sender: AnyObject) {
        let image = generateQRCodeFromString(tfText.text!);
        imgBarcode.image = image;
    }
    
    func generateBarcodeFromString(string: String) -> UIImage? {
        let data = string.dataUsingEncoding(NSASCIIStringEncoding)
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransformMakeScale(3, 3)
            
            if let output = filter.outputImage?.imageByApplyingTransform(transform) {
                return UIImage(CIImage: output)
            }
        }
        
        return nil
    }
    
    func generateQRCodeFromString(string: String) -> UIImage? {
        let data = string.dataUsingEncoding(NSISOLatin1StringEncoding)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel")
            let transform = CGAffineTransformMakeScale(10, 10)
            
            if let output = filter.outputImage?.imageByApplyingTransform(transform) {
                return UIImage(CIImage: output)
            }
        }
        
        return nil
    }

}

