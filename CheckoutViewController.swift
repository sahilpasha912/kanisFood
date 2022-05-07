//
//  CheckoutViewController.swift
//  Foodomia
//
//  Created by Rao Mudassar on 06/05/2020.
//  Copyright © 2020 dinosoftlabs. All rights reserved.
//

import UIKit
import WebKit
import KRProgressHUD

class CheckoutViewController: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var web_view: WKWebView!
    
    var timer = Timer()
    
    var sv  = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        web_view.navigationDelegate = self
        //web_view = webView
        // Do any additional setup after loading the view.
        
        
//        let url = URL(string: "http://apps.qboxus.com/foodies/mobileapp_api/payment/index.php?id="+StaticData.singleton.base64ENCODE!)!
        
        let url = URL(string: "http://store.kanisfood.com/mobileapp_api/payment/index.php?id="+StaticData.singleton.base64ENCODE!)!
        
        let requestObj = URLRequest(url: url as URL)
        web_view.load(requestObj)
        web_view.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
        if(StaticData.singleton.isloader == "yes"){
            
            StaticData.singleton.isloader = "no"
            sv = LogInViewController.displaySpinner(onView: self.view)
        }
        
        if let text = webView.url?.absoluteString{
            print(text)
            if(text.contains("paymentSuccess")){
                StaticData.singleton.isFirstTimeLoad = "no"
                timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
        LogInViewController.removeSpinner(spinner: sv)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        
        LogInViewController.removeSpinner(spinner: sv)
    }
    
    @IBAction func cross(_ sender: Any) {
        
        self.dismiss(animated:true, completion: nil)
    }
    
    
    @objc func update() {
        
        timer.invalidate()
        self.dismiss(animated:true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
