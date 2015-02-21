//
//  DetailViewController.swift
//  SFSampleAppSwift
//
//  Created by Daichi Mizoguchi on 2014/12/10.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: BaseViewController, WKNavigationDelegate {
    
    var accountItem: AccountModel?
    var accountWebView: WKWebView?
    
    
    init(nibName: String, accountItem: AccountModel) {
        super.init(nibName: nibName, bundle: nil)
        self.accountItem = accountItem
    }

    
    required override init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupWebView()
    }
    
    override func viewWillAppear(animated: Bool) {
        accountWebView!.loadRequest(createAccountRequest())
    }
    
    override func viewDidDisappear(animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    
    func setupDesign() {
        let refreshButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "tapRefleshButton")
        self.navigationItem.rightBarButtonItem = refreshButton
    }
    
    
    func setupWebView() {
        accountWebView = WKWebView()
        self.view = accountWebView!
        accountWebView!.navigationDelegate = self
    }
    
    
    func createAccountRequest() -> NSURLRequest {
        let instanceUrl: String = SFRestAPI.sharedInstance().coordinator.credentials.instanceUrl.description
        let accessToken: String = SFRestAPI.sharedInstance().coordinator.credentials.accessToken
        
        let authUrl: String = instanceUrl + "/secur/frontdoor.jsp?sid=" + accessToken + "&retURL="
        let accountUrl: String = instanceUrl + "/apex/AccountMobile?id=" + accountItem!.salesforceId!
        let request: NSURL = NSURL(string:authUrl + accountUrl)!
        let urlRequest: NSURLRequest = NSURLRequest(URL: request)
        return urlRequest
    }
    
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.showWithStatus("読み込み中")
    }
    
    
    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
        self.title = accountWebView!.title
    }
    
    
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        SVProgressHUD.dismiss()
    }
    

    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if (navigationAction.request.URL.absoluteString!.hasPrefix("completed://")) {
            self.navigationController!.popViewControllerAnimated(true)
        }
        
        decisionHandler(WKNavigationActionPolicy.Allow)
    }
    
    
    func tapRefleshButton() {
        accountWebView!.reload()
    }

}
