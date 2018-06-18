//
//  EtalonVC.swift
//  Demo
//
//  Created by Admin on 09.02.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import AlamofireImage

class EtalonVC: UIViewController,UIScrollViewDelegate {
    var etalon = Etalon() {
        didSet {
            guard let price = etalon.priceOptions.first?.customerPrice else { return }
            currentPrice = price
            guard let date = etalon.priceOptions.first?.duration else { return }
            let split = date.split(separator: ".")
            if split.count > 1 {
                currentDate = String(split[0])
            }
            setImage(imageView: imageView, etalon: etalon)
        }
    }
    var etalons:[Etalon] = []
    var etalonOptions: [EtalonOption] = []
    
    var fields:[String] = ["Размер","Вставка"]
    var setEtalon:[Etalon] = []
    
    var imageView = UIImageView()
    var firstTableView = UITableView()
    var currentButton: UIButton?
    var secondTableView = UITableView()
    let lableCount = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
    let lableValue = UILabel()
    let lableDate = UILabel()
    var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var scrollView = UIScrollView()
    var scrollContentView = UIView()
    
    var currentPrice = 0.0 {
        didSet{
            lableValue.text = "Итого: " + String(currentCount * currentPrice)
        }
    }
    var currentDate = "0" {
        didSet{
            lableDate.text = "Количество дней: \(currentDate)"
        }
    }
    var currentCount = 0.0 {
        didSet{
            lableCount.text = String(currentCount)
            lableValue.text = "Итого: " + String(currentCount * currentPrice)
        }
    }
    
    var currentOptionId = 0
    var currentSize = ""
    
    var imageCache = AutoPurgingImageCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //MARK: - create
        self.navigationItem.title = etalon.article
        
        scrollView = UIScrollView(frame: self.view.frame)
        
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addConstraint(NSLayoutConstraint(item: scrollContentView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .topMargin, multiplier: 1, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: scrollContentView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: scrollContentView, attribute: .right, relatedBy: .equal, toItem: scrollView, attribute: .right, multiplier: 1, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: scrollContentView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottomMargin, multiplier: 1, constant: 0))
        scrollContentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        let widht = Int(self.view.frame.width) - 10
        imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: widht, height: widht ))
        setImage(imageView: imageView,etalon: etalon)
        scrollContentView.addSubview(imageView)
        
        firstTableView = UITableView()
        firstTableView.register(UITableViewCell.self, forCellReuseIdentifier: "firstTypeOfCell")
        firstTableView.restorationIdentifier = "FirstTable"
        firstTableView.delegate = self
        firstTableView.dataSource = self
        
        scrollContentView.addSubview(firstTableView)
        
        firstTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addConstraint(NSLayoutConstraint(item: firstTableView, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 15))
        scrollContentView.addConstraint(NSLayoutConstraint(item: firstTableView, attribute: .left, relatedBy: .equal, toItem: scrollContentView, attribute: .left, multiplier: 1, constant: 15))
        scrollContentView.addConstraint(NSLayoutConstraint(item: scrollContentView, attribute: .right, relatedBy: .equal, toItem: firstTableView, attribute: .right, multiplier: 1, constant: 15))
        firstTableView.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor).isActive = true
        firstTableView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        createButtons()
        
        secondTableView = UITableView()
        secondTableView.restorationIdentifier = "SecondTable"
        secondTableView.isScrollEnabled = false
        secondTableView.delegate = self
        secondTableView.dataSource = self
        scrollContentView.addSubview(secondTableView)
        
        secondTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addConstraint(NSLayoutConstraint(item: secondTableView, attribute: .left, relatedBy: .equal, toItem: scrollContentView, attribute: .left, multiplier: 1, constant: 15))
        scrollContentView.addConstraint(NSLayoutConstraint(item: scrollContentView, attribute: .right, relatedBy: .equal, toItem: secondTableView, attribute: .right, multiplier: 1, constant: 15))
        if etalon.description == "" {
            secondTableView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        } else {
            secondTableView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        if let currentButton = currentButton { // create button
            scrollContentView.addConstraint(NSLayoutConstraint(item: secondTableView, attribute: .top, relatedBy: .equal, toItem: currentButton, attribute: .bottom, multiplier: 1, constant: 15))
        } else {
            scrollContentView.addConstraint(NSLayoutConstraint(item: secondTableView, attribute: .top, relatedBy: .equal, toItem: firstTableView, attribute: .bottom, multiplier: 1, constant: 15))
        }
        
        
        let stack = UIStackView()
        stack.alignment = .fill
        stack.spacing = 5
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        let buttonMinus = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        buttonMinus.setTitle("-", for: .normal)
        buttonMinus.setTitleColor(UIColor.black, for: .normal)
        buttonMinus.addTarget(self, action: #selector(actionMinus(sender:)), for: .touchUpInside)
        
        lableCount.text = "0"
        lableCount.textAlignment = .center
        
        let buttonPlus = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        buttonPlus.setTitle("+", for: .normal)
        buttonPlus.setTitleColor(UIColor.black, for: .normal)
        buttonPlus.addTarget(self, action: #selector(actionPlus(sender:)), for: .touchUpInside)
        
        stack.addArrangedSubview(buttonMinus)
        stack.addArrangedSubview(lableCount)
        stack.addArrangedSubview(buttonPlus)
        scrollContentView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor).isActive = true
        
        scrollContentView.addConstraint(NSLayoutConstraint(item: stack, attribute: .top, relatedBy: .equal, toItem: secondTableView, attribute: .bottom, multiplier: 1, constant: 15))
        
        scrollContentView.addSubview(lableValue)
        lableValue.textAlignment = .center
        lableValue.text = "Итого: 0р"
        lableValue.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addConstraint(NSLayoutConstraint(item: lableValue, attribute: .top, relatedBy: .equal, toItem: stack, attribute: .bottom, multiplier: 1, constant: 15))
        lableValue.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor).isActive = true
        
        scrollContentView.addSubview(lableDate)
        lableDate.textAlignment = .center
        lableDate.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addConstraint(NSLayoutConstraint(item: lableDate, attribute: .top, relatedBy: .equal, toItem: lableValue, attribute: .bottom, multiplier: 1, constant: 15))
        lableDate.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor).isActive = true
        
        let buttonBuy = UIButton()
        scrollContentView.addSubview(buttonBuy)
        self.createButtonOptions(buttonBuy)
        buttonBuy.setTitle("Купить", for: .normal)
        scrollContentView.addConstraint(NSLayoutConstraint(item: buttonBuy, attribute: .top, relatedBy: .equal, toItem: lableDate, attribute: .bottom, multiplier: 1, constant: 15))
        
        let buttonAdd = UIButton()
        scrollContentView.addSubview(buttonAdd)
        self.createButtonOptions(buttonAdd)
        buttonAdd.setTitle("Добавить еще", for: .normal)
        scrollContentView.addConstraint(NSLayoutConstraint(item: buttonAdd, attribute: .top, relatedBy: .equal, toItem: buttonBuy, attribute: .bottom, multiplier: 1, constant: 15))
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.backgroundColor = UIColor.white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        scrollContentView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: buttonAdd, attribute: .bottom, multiplier: 1, constant: 5))
        scrollContentView.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: scrollContentView, attribute: .left, multiplier: 1, constant: 0))
        scrollContentView.addConstraint(NSLayoutConstraint(item: scrollContentView, attribute: .right, relatedBy: .equal, toItem: collectionView, attribute: .right, multiplier: 1, constant: 0))
        scrollContentView.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: scrollContentView, attribute: .bottom, multiplier: 1, constant: 5))
        collectionView.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        
        self.view.addSubview(scrollView)
        scrollView.delegate = self
        
        //MARK: - load data
        loadVariations()
        if etalons.count != 0 {
            loadEtalonSet()
        }
        
        
    }
    //MARK: - methods
    
    fileprivate func setImage(imageView: UIImageView, etalon: Etalon) {
        if let image = imageCache.image(withIdentifier: etalon.imageURL.absoluteString){
            imageView.image = image
        } else {
            let url = etalon.imageURL
            imageView.af_setImage(withURL: url,placeholderImage: #imageLiteral(resourceName: "Image-5")) { (response) in
                guard let data = response.data else { return }
                self.imageCache.add(UIImage(data: data)!, withIdentifier: self.etalon.imageURL.absoluteString)
            }
        }
    }
    
    fileprivate func createButtonOptions(_ button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.blue.cgColor
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        scrollContentView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: scrollContentView, attribute: .left, multiplier: 1, constant: 15))
        scrollContentView.addConstraint(NSLayoutConstraint(item: scrollContentView, attribute: .right, relatedBy: .equal, toItem: button, attribute: .right, multiplier: 1, constant: 15))
        
        button.addTarget(self, action: #selector(actionChangePriceAndDate(sender:)), for: .touchUpInside)
    }
    
    fileprivate func createButtons() {
        currentButton = nil
        
        guard etalon.priceOptions.count != 0 else { return }
        if etalon.priceOptions.count <= 3 {
            for priceOption in etalon.priceOptions {
                let button = UIButton()
                let split = priceOption.duration.split(separator: ".")
                var durationDays = "0"
                if split.count > 1 {
                    durationDays = String(split[0])
                }
                button.setTitle("\(priceOption.customerPrice) - \(durationDays) дня(ей)" , for: .normal)
                scrollContentView.addSubview(button)
                createButtonOptions(button)
                if let currentButton = currentButton {
                    scrollContentView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: currentButton, attribute: .bottom, multiplier: 1, constant: 15))
                } else {
                    scrollContentView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: firstTableView, attribute: .bottom, multiplier: 1, constant: 15))
                }
                currentButton = button
            }
        } else {
            var durationDays = "0"
            var split = etalon.priceOptions[0].duration.split(separator: ".")
            if split.count > 1 {
                durationDays = String(split[0])
            }
            let button1 = UIButton()
            createButtonOptions(button1)
            button1.setTitle("\(etalon.priceOptions[0].customerPrice) - \(durationDays) дней", for: .normal)
            
            durationDays = "0"
            split = etalon.priceOptions[1].duration.split(separator: ".")
            if split.count > 1 {
                durationDays = String(split[0])
            }
            let button2 = UIButton()
            createButtonOptions(button2)
            button2.setTitle("\(etalon.priceOptions[1].customerPrice) - \(durationDays) дней", for: .normal)
            
            let button3 = UIButton()
            createButtonOptions(button3)
            button3.setTitle("Другие опции", for: .normal)
            button3.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
            currentButton = button3
            scrollContentView.addSubview(button1)
            scrollContentView.addSubview(button2)
            scrollContentView.addSubview(button3)
           
            scrollContentView.addConstraint(NSLayoutConstraint(item: button1, attribute: .top, relatedBy: .equal, toItem: firstTableView, attribute: .bottom, multiplier: 1, constant: 15))
            scrollContentView.addConstraint(NSLayoutConstraint(item: button2, attribute: .top, relatedBy: .equal, toItem: button1, attribute: .bottom, multiplier: 1, constant: 15))
            scrollContentView.addConstraint(NSLayoutConstraint(item: button3, attribute: .top, relatedBy: .equal, toItem: button2, attribute: .bottom, multiplier: 1, constant: 15))
        }
    }
    
    fileprivate func loadVariations() {
        VendorDistributionPointShowcaseEtalonVariationsAPI.getVendorDistributionPointShowcaseEtalonVariations(vendorId: etalon.terminal.vendorId, pointId: etalon.terminal.pointId, showcaseId: etalon.terminal.showcaseId, etalonId: etalon.id) { (etalonVariations, error) in
            guard let etalonVariations = etalonVariations else { return }
            self.etalonOptions = []
            for variation in etalonVariations {
                guard let id = variation.id else { continue }
                guard let options = variation.options else { continue }
                //guard let price = variation.price else { continue }
                
                guard let size = options["Size"] as? String else { continue }
                guard let gemstone = options["Gemstone"] as? String else { continue }
                
                guard !self.etalonOptions.contains(where: { (option) -> Bool in
                    return option.id == id
                }) else { continue }
                
                self.etalonOptions.append(EtalonOption(id: id, size: size, gemstone: gemstone))
            }
            self.firstTableView.reloadData()
        }
    }
    
    fileprivate func loadEtalonSet() {
        VendorDistributionPointShowcaseEtalonsAPI.getVendorDistributionPointShowcaseEtalonSet(vendorId: etalon.terminal.vendorId, pointId: etalon.terminal.pointId, showcaseId: etalon.terminal.showcaseId, id: etalon.id) { (set, error) in
            guard let set = set else { return }
            guard let etalonsId = set.etalons else { return }
            self.setEtalon = []
            for etalonId in etalonsId {
                guard let etalon = self.etalons.first(where: { (etalon) -> Bool in
                    return etalon.id == etalonId
                }) else { continue }
                self.setEtalon.append(etalon)
            }
        
            if let constraint = self.collectionView.constraints.first(where: { (constraint) -> Bool in
                return constraint.firstAttribute == NSLayoutAttribute.height
            }) {
                NSLayoutConstraint.deactivate([constraint])
                var height = CGFloat()
                if self.setEtalon.count % 2 == 0 {
                     height = CGFloat(305 * self.setEtalon.count/4 )
                } else {
                     height = CGFloat(305 * self.setEtalon.count/4 + 150)
                }
                self.collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - button action
    
    @objc fileprivate func action(sender: UIButton) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popOverVCId") as! PopOverVC
        popOverVC.priceOptions = etalon.priceOptions
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    @objc fileprivate func actionMinus(sender: UIButton) {
        guard let title = lableCount.text else { return }
        guard let titleInt = Double(title) else { return }
        guard titleInt > 0 else { return }
        currentCount = titleInt - 1
    }
    
    @objc fileprivate func actionPlus(sender: UIButton) {
        guard let title = lableCount.text else { return }
        guard let titleInt = Double(title) else { return }
        currentCount = titleInt + 1
    }
    @objc fileprivate func actionChangePriceAndDate(sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        let split = title.split(separator: " ")
        guard let price = Double(split[0]) else { return }
        currentPrice = price
        currentDate = String(split[2])
        
    }
    @IBAction func unwindSegueForPopOver(sender: UIStoryboardSegue) {
       
    }
    
    @IBAction func unwindSegue(sender: UIStoryboardSegue) {
        VendorDistributionPointShowcaseEtalonVariationsAPI.getVendorDistributionPointShowcaseEtalonVariationPrices(vendorId: etalon.terminal.vendorId, pointId: etalon.terminal.pointId, showcaseId: etalon.terminal.showcaseId, etalonId: etalon.id, id: currentOptionId) { (variationPrice, error) in
            guard let variationPrice = variationPrice  else{ return }
            guard let options = variationPrice.options else { return }
            var newPriceOptions: [PriceOption] = []
            for option in options  {
                guard let customerPrice = option.customerPrice else { continue }
                guard let duration = option.duration else { continue }
                newPriceOptions.append(PriceOption(customerPrice: customerPrice, duration: duration))
            }
            self.etalon.priceOptions = newPriceOptions
            guard let price = newPriceOptions.first?.customerPrice else { return }
            self.currentPrice = price
            
            self.createButtons()
            if let currentButton = self.currentButton  {
                self.scrollContentView.addConstraint(NSLayoutConstraint(item: self.secondTableView, attribute: .top, relatedBy: .equal, toItem: currentButton, attribute: .bottom, multiplier: 1, constant: 15))
            } else {
                self.scrollContentView.addConstraint(NSLayoutConstraint(item: self.secondTableView, attribute: .top, relatedBy: .equal, toItem: self.firstTableView, attribute: .bottom, multiplier: 1, constant: 15))
            }
            guard let date = newPriceOptions.first?.duration else { return }
            let split = date.split(separator: ".")
            if split.count > 1 {
                self.currentDate = String(split[0])
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let destination: EtalonOptionVC = segue.destination as? EtalonOptionVC {
            if let indexPath = self.firstTableView.indexPathForSelectedRow {
                destination.index = indexPath.row
                if currentSize == "" {
                    guard let option = etalonOptions.first else { return }
                    destination.currentSize = option.size
                } else {
                    destination.currentSize = currentSize
                }
                destination.etalonOptions = etalonOptions
            }
            return
        }
        if let destination: MapVC = segue.destination as? MapVC {
            destination.etalonTerminal = etalon.terminal
        }
    }
    
}
//MARK: - table extension
extension EtalonVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.restorationIdentifier == "FirstTable" {
            return fields.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.restorationIdentifier == "FirstTable" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstTypeOfCell")
            cell?.textLabel?.text = fields[indexPath.row]
            
            cell?.accessoryType = .disclosureIndicator
            return cell!
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Описание \n\(etalon.description)"
            cell.textLabel?.numberOfLines = 1
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.restorationIdentifier == "FirstTable" {
            performSegue(withIdentifier: "showOptionVC", sender: tableView.cellForRow(at: indexPath))
        } else {
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            if let constraint = tableView.constraints.first(where: { (constraint) -> Bool in
                return constraint.firstAttribute == .height
            }) {
                NSLayoutConstraint.deactivate([constraint])
            }
            guard let textLabel = cell.textLabel else { return }
            if textLabel.numberOfLines == 1 {
                textLabel.numberOfLines = 0
                UIView.animate(withDuration: 0.4, animations: {
                    tableView.frame.size.height = 300
                })
                tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
                tableView.separatorStyle = .none
                tableView.isScrollEnabled = true
            } else {
                textLabel.numberOfLines = 1
                tableView.separatorStyle = .singleLine
                tableView.heightAnchor.constraint(equalToConstant: 50).isActive = true
                tableView.isScrollEnabled = false
            }
            cell.sizeToFit()
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
//MARK: - collection extension
extension EtalonVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setEtalon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
       
        let imageView = UIImageView()
        cell.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        cell.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: cell, attribute: .top, multiplier: 1, constant: 0))
        cell.addConstraint(NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: cell, attribute: .left, multiplier: 1, constant: 0))
        cell.addConstraint(NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: cell, attribute: .right, multiplier: 1, constant: 0))
        cell.addConstraint(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: cell, attribute: .bottom, multiplier: 1, constant: 0))
        
        setImage(imageView: imageView, etalon: setEtalon[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        etalon = setEtalon[indexPath.row]
        createButtons()
        if let currentButton = self.currentButton {
            scrollContentView.addConstraint(NSLayoutConstraint(item: secondTableView, attribute: .top, relatedBy: .equal, toItem: currentButton, attribute: .bottom, multiplier: 1, constant: 15))
        } else {
            scrollContentView.addConstraint(NSLayoutConstraint(item: secondTableView, attribute: .top, relatedBy: .equal, toItem: firstTableView, attribute: .bottom, multiplier: 1, constant: 15))
        }
        loadVariations()
        if let constraint = secondTableView.constraints.first(where: { (constraint) -> Bool in
            return constraint.firstAttribute == .height && constraint.constant != 50
        }) {
            NSLayoutConstraint.deactivate([constraint])
            secondTableView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        secondTableView.reloadData()
        loadEtalonSet()
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = collectionView.frame.size.width
        let xInsents: CGFloat = 10
        let cellSpasing: CGFloat = 5
        return CGSize(width: (width/numberOfColumns) - (xInsents+cellSpasing)-10, height: CGFloat(width/numberOfColumns) - (xInsents+cellSpasing))
    }
}
