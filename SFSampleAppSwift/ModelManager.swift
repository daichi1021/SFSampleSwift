//
//  UserModel.swift
//  SFSampleAppSwift
//
//  Created by Daichi Mizoguchi on 2014/12/10.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

import Foundation

class ModelManager : NSObject {
    
    var type: String = ""
    
    init(modelType: String) {
        super.init()
        self.type = modelType
        
    }
    
    var models = [BaseModel]()
    
    func getRecords() -> [BaseModel] {
        return models
    }
    
    func setRecords(records: NSDictionary!) {
        if let dict = records {
            if let array: NSArray = dict["records"] as? NSArray {
                var tmpObjects = [BaseModel]()
                for record in array {
                    tmpObjects.append(createModel(self.type, record: record))
                }
                self.models = tmpObjects
            }
        }
    }
    
    // 引数のタイプによってインスタンス化するモデルを切り替え
    func createModel(type: String, record: AnyObject) -> BaseModel {
        if (type == AccountModel.description()) {
            return AccountModel(record: record as! NSDictionary)
        }
        return BaseModel(record: record as! NSDictionary)
    }
}