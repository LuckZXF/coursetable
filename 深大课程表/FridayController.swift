//
//  FridayController.swift
//  深大课程表
//
//  Created by 赵希帆 on 15/11/26.
//  Copyright © 2015年 赵希帆. All rights reserved.
//

import UIKit

class FridayController : UIViewController {
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url : NSURL! = NSURL(string: "http://www.baidu.com")
        let request : NSURLRequest = NSURLRequest(URL: url)
        self.view.addSubview(webView)
        webView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
