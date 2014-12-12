//
//  DetailViewController.swift
//  SFSampleAppSwift
//
//  Created by Daichi Mizoguchi on 2014/12/10.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    var accountItem: AccountModel?
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextArea: UITextView!
    
    
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
    }
    
    
    func setupDesign () {
        idTextField.text = accountItem?.salesforceId
        nameTextField.text = accountItem?.accountName
        phoneTextField.text = accountItem?.phone
        addressTextArea.text = accountItem?.billingAddress
    }

}
