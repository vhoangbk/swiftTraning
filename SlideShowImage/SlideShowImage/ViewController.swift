//
//  ViewController.swift
//  SlideShowImage
//
//  Created by paraline on 7/26/16.
//  Copyright © 2016 paraline. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var scrollImage: UIScrollView!
    
    let listImages : [String] = ["image1", "image2", "image3", "image4", "image5"];
    
    var currentIndex = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollImage.delegate = self;
        
        self.scrollImage.frame.size.width = UIScreen.mainScreen().bounds.width;
        
        for i in 0..<listImages.count {
            lbName.text = listImages[i];
            let image = UIImage(named: listImages[i]);
            let imageView = UIImageView(frame: CGRect(x: scrollImage.frame.size.width * CGFloat(i), y: 0, width: scrollImage.frame.size.width, height: scrollImage.frame.height));
            imageView.image = image;
            scrollImage.addSubview(imageView);
            scrollImage.contentSize = CGSize(width: scrollImage.frame.size.width * CGFloat(listImages.count), height: scrollImage.frame.size.height);
        }
        
        showPageAtIndex(currentIndex);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func previous(sender: AnyObject) {
        if (currentIndex == 0) {
            return;
        }
        currentIndex -= 1;
        showPageAtIndex(currentIndex);
    }

    @IBAction func next(sender: AnyObject) {
        if (currentIndex == listImages.count - 1) {
            return;
        }
        currentIndex += 1;
        showPageAtIndex(currentIndex);
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        currentIndex = Int(scrollImage.contentOffset.x / scrollImage.frame.size.width);
        lbName.text = listImages[currentIndex];
    }
    
    // hien thi anh theo chi so
    func showPageAtIndex(index : Int) {
        scrollImage.scrollRectToVisible(CGRectMake(self.scrollImage.frame.size.width * CGFloat(index), scrollImage.frame.origin.y, scrollImage.frame.size.width, scrollImage.frame.size.height), animated: true);
        lbName.text = listImages[index];
    }
    
  
}

