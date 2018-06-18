//
//  OptionsVC.swift
//  
//
//  Created by Admin on 17.01.18.
//

import UIKit

class OptionsVC : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView! 

    var fields: [Field] = []
    var allFilds: [Field] = []
    var options:[Option] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fields.append(Field(name: "Сортировка", uniqueKey: "Сортировка", type: "Сортировка", isMeasurable: false, minValue: nil, maxValue: nil, stringValues: []))
        let currentCategories = commodityCategory
        var names:[String] = []
        for category in currentCategories {
            names.append(category.name)
        }
        fields.append(Field(name: "Подкатегория", uniqueKey: "Подкатегория", type: "String", isMeasurable: false, minValue: nil, maxValue: nil, stringValues: names))
        SharedCommodityCategoriesAPI.getCommodityCategories { (categories, error) in
            guard let categories = categories else { return }
            for category in categories {
                guard let id = category.id else { continue }
                guard id == currentCategories[0].id else { continue }
                self.findAllFields(category: category)
                break
            }
            
            for option in self.options {
                guard let index = self.allFilds.index(where: { (field) -> Bool in
                    return field.uniqueKey == option.key
                }) else { continue }
                if !self.allFilds[index].isMeasurable {
                    guard let stringValues = self.allFilds[index].stringValues else { continue }
                    if self.allFilds[index].type == "String" {
                        guard let stringValue = option.value as? String else { continue }
                        guard !stringValues.contains(where: { (value) -> Bool in
                            return value == stringValue.lowercased()
                        }) else { continue }
                        self.allFilds[index].stringValues?.append(stringValue.lowercased())
                        continue
                    }
                    if self.allFilds[index].type == "Boolean" {
                        self.allFilds[index].stringValues = ["Да","Нет"]
                        continue
                    }
                } else {
                    if self.allFilds[index].type == "FloatingPoint" {
                        guard let doubleValue = option.value as? Double else { continue }
                        guard let min = self.allFilds[index].minValue else { continue }
                        guard let max = self.allFilds[index].maxValue else { continue }
                        
                        if doubleValue < min {
                            self.allFilds[index].minValue = doubleValue
                        }
                        if doubleValue > max {
                            self.allFilds[index].maxValue = doubleValue
                        }
                    }
                }
            }
            
            
            for field in self.allFilds {
                if field.isMeasurable {
                    if field.minValue == 40000.0 && field.maxValue == -40000.0 { continue }
                } else {
                    guard let values = field.stringValues else { continue }
                    if values.isEmpty { continue }
                }
                
                if !self.fields.contains(where: { (currentField) -> Bool in
                    return currentField.name == field.name
                }) {
                    self.fields.append(field)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellForOptionsVC
        cell.Title.text = fields[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let index = tableView.indexPathForSelectedRow else { return }
        if fields[index.row].minValue != nil || fields[index.row].maxValue != nil {
            performSegue(withIdentifier: "segueToOptionVC", sender: nil)
        } else {
            performSegue(withIdentifier: "segueToOptionTableVC", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = tableView.indexPathForSelectedRow else { return }
    
        if let destination: OptionTableVC = segue.destination as? OptionTableVC {
            destination.option = fields[index.row]
        } else {
            if let destination: OptionVC = segue.destination as? OptionVC {
                destination.option = fields[index.row]
            }
        }
        tableView.deselectRow(at: index, animated: false)
    }
    //MARK: - methods
    
    func findAllFields(category: CommodityCategoryGetApiModel) {
        if let loadedFields = category.fields  {
            for field in loadedFields {
                guard let field = field.field else { continue }
                guard let name = field.name else { continue }
                guard let uniqueKey = field.uniqueKey else { continue }
                guard let type = field.type else { continue }
                if type.rawValue == "FloatingPoint" {
                    if !fields.contains(where: { (field) -> Bool in
                        return field.name == name
                    }){
                        let field = Field(name: name, uniqueKey: uniqueKey, type: type.rawValue, isMeasurable: true, minValue: 40000.0, maxValue: -40000.0, stringValues: nil)
                        self.allFilds.append(field)
                    }
                    continue
                }
            
                if !allFilds.contains(where: { (field) -> Bool in
                    return field.name == name
                }){
                    let field = Field(name: name, uniqueKey: uniqueKey, type: type.rawValue, isMeasurable: false, minValue: nil, maxValue: nil, stringValues: [])
                    self.allFilds.append(field)
                }
                
            }
        }
        if let childrens = category.children {
            for children in childrens {
                findAllFields(category: children)
            }
        }
    }
    
    //MARK: - action for buttons
    @IBAction func acceptButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        Filter.clearFilter()
    }
}
