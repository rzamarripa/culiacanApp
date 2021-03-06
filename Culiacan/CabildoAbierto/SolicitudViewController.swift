//
//  SolicitudViewController.swift
//  Culiacan
//
//  Created by Armando Trujillo on 09/12/14.
//  Copyright (c) 2014 RedRabbit. All rights reserved.
//

import UIKit

class SolicitudViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView : UIWebView!
    var urlArchivo : String!
    
    private var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        spinner.center = CGPointMake(UIScreen.mainScreen().applicationFrame.size.width / 2.0, UIScreen.mainScreen().applicationFrame.size.height / 2.0)
        spinner.color = UIColor.blackColor()
        self.view.addSubview(spinner)
        spinner.startAnimating()
        
        let nsUrl : NSURL = NSURL(string: urlArchivo)!
        let request : NSURLRequest = NSURLRequest(URL: nsUrl)
        webView.delegate = self
        webView.loadRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: - WebView Delegate
    func webViewDidFinishLoad(webView: UIWebView) {
        spinner.stopAnimating()
    }
    
    //MARK: - IBActions Buttons
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
}
