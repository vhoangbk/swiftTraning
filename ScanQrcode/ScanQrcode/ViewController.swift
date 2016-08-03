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
    
    
    @IBOutlet var previewView: UIView!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureSession : AVCaptureSession!
    var metadataOutput: AVCaptureMetadataOutput!
    var videoDevice:AVCaptureDevice!
    var videoInput: AVCaptureDeviceInput!
    var running = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        if(videoDevice == nil){
            print("No camera on this device")
            return
        }
        
        captureSession = AVCaptureSession()
        videoInput = (try! AVCaptureDeviceInput(device: videoDevice) as AVCaptureDeviceInput)
        
        if(captureSession.canAddInput(videoInput)){
            captureSession.addInput(videoInput)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        metadataOutput = AVCaptureMetadataOutput()
        let metadataQueue = dispatch_queue_create("com.example.QRCode.metadata", nil)
        metadataOutput.setMetadataObjectsDelegate(self, queue: metadataQueue)
        
        
        if(captureSession.canAddOutput(metadataOutput)){
            captureSession.addOutput(metadataOutput)
        }

        previewLayer.frame = previewView.bounds
        previewView.layer.addSublayer(previewLayer)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRunning(){
        if captureSession == nil {
            return
        }
        
        captureSession.startRunning()
        metadataOutput.metadataObjectTypes =
            metadataOutput.availableMetadataObjectTypes
        running = true
    }
    
    func stopRunning(){
        if captureSession == nil {
            return
        }
        captureSession.stopRunning()
        running = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startRunning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopRunning()
    }
    
    //goi khi scan success
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        stopRunning();
        let elemento = metadataObjects.first as?
        AVMetadataMachineReadableCodeObject
        if(elemento != nil){
            print(elemento!.stringValue)
            
            let alert = UIAlertController(title: "", message: elemento!.stringValue, preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert : UIAlertAction) in
                self.startRunning();
            })
            
            alert.addAction(action)
            self.presentViewController(alert, animated: false, completion: nil)
        }
    }

}

