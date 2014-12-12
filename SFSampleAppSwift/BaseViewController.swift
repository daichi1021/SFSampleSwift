//
//  BaseViewController.swift
//  SFSampleAppSwift
//
//  Created by Daichi Mizoguchi on 2014/12/11.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func requestQuery (queryString: String, tag: Int) {
        SFRestAPI.sharedInstance().performSOQLQuery(queryString,
            failBlock: {(e: NSError!) -> () in self.queryFailed(e)},
            completeBlock: {(result :[NSObject:AnyObject]!) -> () in self.queryCompleted(result, tag: tag)})
    }
    
    
    // 各ViewControllerでオーバーライドし、処理を記述する
    func queryCompleted(result :[NSObject:AnyObject]!, tag :Int) {}
    
    
    func queryFailed(e: NSError) {
        var alertController = UIAlertController(title: "クエリエラー", message: e.localizedDescription, preferredStyle: .Alert)
        let returnAction = UIAlertAction(title: "OK", style: .Default) {
            action in println(e.localizedDescription)
        }
        alertController.addAction(returnAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // GCDを簡易的に記述する為のメソッド
    func dispatch_async_main(block: () -> ()) {
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
}
