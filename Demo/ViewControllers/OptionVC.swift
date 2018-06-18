//
//  OptionVC.swift
//  Demo
//
//  Created by Admin on 05.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class OptionVC: UIViewController {
    
    var option: Field?
    
    
    @IBOutlet weak var textFieldFrom: UITextField! {
        didSet {
            guard let option = option else { return }
            if let from = option.minValue {
                textFieldFrom.placeholder = String(from)
            } else {
                textFieldFrom.placeholder = String(0.0)
            }
        }
    }
    @IBOutlet weak var textFieldTo: UITextField! {
        didSet {
            guard let option = option else { return }
            if let from = option.maxValue {
                textFieldTo.placeholder = String(from)
            } else {
                textFieldTo.placeholder = String(0.0)
            }
        }
    }
    
    @IBAction func buttonApply(_ sender: UIButton) {
        guard let option = option else { return }
        guard let from = textFieldFrom.text else { return }
        guard let to = textFieldFrom.text else { return }
        
        if  from == "" && to == ""  {
            Filter.clearFilterOption(uniqueKey: option.uniqueKey)
            navigationController?.popViewController(animated: true)
        }
        guard  from != "" && to != "" else { return }
        guard let doubleFrom = Double(from) else { return }
        guard let doubleTo = Double(from) else { return }
        Filter.appendFilterOption(uniqueKey:option.uniqueKey , minValue: doubleFrom, maxValue: doubleTo)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = option?.name
    }
}
