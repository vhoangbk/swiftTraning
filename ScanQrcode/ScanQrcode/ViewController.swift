//
//  ViewController.swift
//  ScanQrcode
//
//  Created by paraline on 8/3/16.
//  Copyright © 2016 paraline. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
	//view de hien thi camera
    @IBOutlet var previewView: UIView!
	@IBOutlet var lbResult: UILabel!
	
	//layer camera
    var previewLayer: AVCaptureVideoPreviewLayer!
	
	//kiem tra co camera
	var videoDevice:AVCaptureDevice!
	var videoInput: AVCaptureDeviceInput!
	
    var metadataOutput: AVCaptureMetadataOutput!
	
	//quan ly start, stop camera
	var captureSession : AVCaptureSession!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        if(videoDevice == nil){
            print("No camera on this device")
            return
        }
		
		videoInput = try! AVCaptureDeviceInput(device: videoDevice)
	
		captureSession = AVCaptureSession()
		
        if(captureSession.canAddInput(videoInput)){
            captureSession.addInput(videoInput)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
		
        metadataOutput = AVCaptureMetadataOutput()
        metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_queue_create("qrcode", nil))
        if(captureSession.canAddOutput(metadataOutput)){
            captureSession.addOutput(metadataOutput)
        }
		
        previewLayer.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.width)
        previewView.layer.addSublayer(previewLayer)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startScan(){
		if (captureSession.running == false) {
			captureSession.startRunning()
			metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
		}
		
    }
    
    func stopScan(){
		if (captureSession.running == true){
			captureSession.stopRunning()
		}
    }
	
    
	@IBAction func scan(sender: AnyObject) {
		startScan();
	}
	
	
	@IBAction func stop(sender: AnyObject) {
		stopScan()
	}
	
	
    //goi khi scan success
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        stopScan()
		let data = metadataObjects.first;
        if(data != nil){
			
			dispatch_async(dispatch_get_main_queue(),{
				self.lbResult.text = data?.stringValue!;
			});
			
        }
    }

}

