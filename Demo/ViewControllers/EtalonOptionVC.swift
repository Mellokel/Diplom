//
//  EtalonOptionVC.swift
//  Demo
//
//  Created by Admin on 14.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class EtalonOptionVC: UITableViewController {
    
    var etalonOptions:[EtalonOption] = []
    var tableArray:[String] = []
    var index: Int = 0
    var currentSize: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if index == 0 {
            for option in etalonOptions {
                guard !tableArray.contains(option.size) else { continue }
                tableArray.append(option.size)
            }
        } else {
            for option in etalonOptions.filter({ (option) -> Bool in
                return option.size == currentSize
            }) {
                guard !tableArray.contains(option.gemstone) else { continue }
                tableArray.append(option.gemstone)
            }
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EtalonVC {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            if index == 0 {
                destination.currentSize = tableArray[indexPath.row]
                guard let option = etalonOptions.first(where: { (option) -> Bool in
                    return option.size == tableArray[indexPath.row]
                }) else { return }
                destination.currentOptionId = option.id
            } else {
                guard let option = etalonOptions.first(where: { (option) -> Bool in
                    return option.size == currentSize && option.gemstone == tableArray[indexPath.row]
                }) else { return }
                destination.currentOptionId = option.id
            }
        }
    }
}
