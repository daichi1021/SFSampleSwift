//
//  UserData.swift
//  SFSampleAppSwift
//
//  Created by Daichi Mizoguchi on 2014/12/10.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

import Foundation

class AccountModel: BaseModel {
    
    var salesforceId: String?
    var accountName: String?
    var phone: String?
    var billingAddress: String?
    
    
    override init(record: NSDictionary) {
        super.init(record: record)
        self.setModel(record)
    }
    
    override func setModel(account: NSDictionary){
        let salesforceId: AnyObject?   = account["Id"]
        let accountName: AnyObject? = account["Name"]
        let phone: AnyObject? = account["phone"]
        let billingAddress: AnyObject? = account["BillingAddress"]

        self.salesforceId   = salesforceId as? String
        self.accountName = accountName as? String
        self.phone = phone as? String
        self.billingAddress = billingAddress as? String
    }
}
