//
//  ViewController.swift
//  ShowImageFromInternet
//
//  Created by paraline on 7/29/16.
//  Copyright © 2016 paraline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    
    let listUrl : [String] = ["http://vui3g.com/files/posts/images/5-2014/girl-xinh-dan-toc-mong.jpg",
                            "http://img.v3.news.zdn.vn/w660/Uploaded/abhuuah/2014_06_23/TMK_8707_zing.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showImage1(sender: AnyObject) {
        imageview.sd_setImageWithURL(NSURL(string: listUrl[0]))
    }

    @IBAction func showImage2(sender: AnyObject) {
        imageview.sd_setImageWithURL(NSURL(string: listUrl[1]))
    }
    
}

