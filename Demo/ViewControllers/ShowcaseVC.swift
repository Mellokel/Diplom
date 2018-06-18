//
//  ShowcaseVC.swift
//  Demo
//
//  Created by Admin on 11.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import CoreData

fileprivate let searchBarHeight: Int = 40

class ShowcaseVC: UICollectionViewController {
    @IBOutlet var myCollectionView: UICollectionView!
    @IBOutlet weak var myNavigationBar: UINavigationItem!
    //MARK: var
    var seviceFeeNumber :Int = 0
    var seviceFeeName :String = ""
    
    var counterForElements = 20
    
    var isSearching:Bool = false
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: searchBarHeight))
    
    var filtered:[Etalon] = []
    var etalon:[Etalon] = []
    var savedEtalonsId:[Int] = []
    
    var isSorted:Bool = false
    var needReload: Bool = false
 
    let imageCache = AutoPurgingImageCache()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: func
    override func viewDidLoad() {
        super.viewDidLoad()
        myNavigationBar.title = self.seviceFeeName
        
        Filter.clearFilter()
        self.searchBar.placeholder = "Search"
        self.myCollectionView.addSubview(self.searchBar)
        self.searchBar.delegate = self 
        
        
        
        Helper.getEtalons(seviceFeeNumber: self.seviceFeeNumber) { (etalons,commodityCategory,terminal, Error) in
            guard let etalons = etalons else { return }
            var identifiers:UploadImageResolveApiModel?
            for etalon in etalons {
                guard let categoryId = etalon.commodityCategoryId else { continue }
                guard commodityCategory.contains(where: { (category) -> Bool in
                    return category.id == categoryId
                }) else { continue }
                guard let id = etalon.id else { continue }
                //guard let name = etalon.name else { continue }
                guard let article = etalon.article else { continue }
                guard let imageId = etalon.imageId else { continue }
                guard let variations = etalon.variations else { continue }
                guard let variation = variations.first else { continue }
                guard let priceOptions = variation.priceOptions else { continue }
                guard !priceOptions.isEmpty else { continue }
                
                var newEtalon = Etalon()
                newEtalon.id = id
                newEtalon.terminal = terminal
                newEtalon.categoryId = categoryId
                newEtalon.article = article
                if let description = etalon.description {
                    newEtalon.description = description
                }
                
                for variationPriceOption in priceOptions {
                    guard let customerPrice = variationPriceOption.customerPrice else { continue }
                    guard let duration = variationPriceOption.duration else { continue }
                    newEtalon.priceOptions.append(PriceOption(customerPrice: customerPrice, duration: duration))
                }
                
                for variation in variations {
                    guard let params = variation.params else { continue }
                    var options: [Option] = []
                    for param in params {
                        options.append(Option(key: param.key, value: param.value))
                    }
                    newEtalon.filterOptions.append(options)
                }
                
                if let identifiers = identifiers {
                    identifiers.identifiers?.append(imageId)
                } else {
                    identifiers = UploadImageResolveApiModel(identifiers:[imageId])
                }
                
                self.etalon.append(newEtalon)
            }
            if let identifiers = identifiers {
                Helper.getImagesUrl(identifiers: identifiers, completion: { (article, url) in
                    if let index = self.etalon.index(where: { (a) -> Bool in
                        return a.article == article
                    }) {
                        self.etalon[index].imageURL = url
                    }
                }, endOfFunc: {
                    self.etalon = self.etalon.filter({ (etalon) -> Bool in
                        return !etalon.imageURL.isFileURL
                    })
                    self.myCollectionView.reloadData()
                })
            }
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = appDelegate.persistentContainer.viewContext
        savedEtalonsId = []
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EtalonCD")
        do {
            let etalonFetch = try context.fetch(fetchedRequest) as! [EtalonCD]
            for etalon in etalonFetch {
                savedEtalonsId.append(Int(etalon.id))
            }
            
        } catch {}
        collectionView?.reloadData()
    }
   
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellForShowcaseVC
        cell.article.text = nil
        cell.price.text = nil
        cell.image.image = nil
        var values:[Etalon] = isSearching || isSorted ? filtered : etalon
        
        cell.article.text = "\(values[indexPath.row].name) \(values[indexPath.row].article)"
        cell.price.text = "От \(values[indexPath.row].priceOptions[0].customerPrice)"
        cell.likeButton.addTarget(self, action: #selector(addToCoreData(sender:)), for: .touchUpInside)
        
        if savedEtalonsId.contains(values[indexPath.row].id) {
            cell.likeButton.setTitleColor(.red, for: .normal)
        } else {
            cell.likeButton.setTitleColor(.black, for: .normal)
        }
        
        if let image = imageCache.image(withIdentifier: values[indexPath.row].imageURL.absoluteString) {
            cell.image.image = image
        } else {
            self.createImage(index: indexPath.row,cell)
        }
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = isSearching || isSorted ? filtered.count : etalon.count
        if indexPath.row == counterForElements - 4 {
            if count >= counterForElements + 4 {
                let newIndexPath1 = IndexPath( item: counterForElements    , section: 0 )
                let newIndexPath2 = IndexPath( item: counterForElements+1    , section: 0 )
                let newIndexPath3 = IndexPath( item: counterForElements+2    , section: 0 )
                let newIndexPath4 = IndexPath( item: counterForElements+3    , section: 0 )
              
                counterForElements += 4
                collectionView.performBatchUpdates({
                    collectionView.insertItems(at: [newIndexPath1,newIndexPath2,newIndexPath3,newIndexPath4])
                }, completion: { (result) in
                    if result {
                        collectionView.reloadData()
                    }
                })
            } else {
                var indexPathArray:[IndexPath] = []
                for item in counterForElements..<count {
                    indexPathArray.append(IndexPath(item: item, section: 0))
                }
                guard !indexPathArray.isEmpty else { return }
                counterForElements = count
                collectionView.performBatchUpdates({
                    collectionView.insertItems(at: indexPathArray)
                }, completion: { (result) in
                    if result {
                        collectionView.reloadData()
                    }
                })
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching || isSorted{
            if filtered.count < counterForElements {
                return filtered.count
            } else {
                return counterForElements
            }
        }else{
            if etalon.count < counterForElements {
                return etalon.count
            } else {
                return counterForElements
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: Int(myCollectionView.bounds.width), height: searchBarHeight)	
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isSearching {
            isSorted = false
        } else {
            let sorts = Filter.getFilterOptions()
            guard needReload else { return }
            if !sorts.isEmpty {
                isSorted = true
                filterOut()
            } else {
                isSorted = false
                myCollectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EtalonVC {
            let indexPath = self.collectionView?.indexPathsForSelectedItems
            let value = isSearching || isSorted ? filtered[indexPath![0].row] : etalon[indexPath![0].row]
            destination.etalon = value
            destination.etalons = etalon
            destination.imageCache = imageCache
            needReload = false
        }
        if let destination = segue.destination as? OptionsVC {
            var options:[Option] = []
            for etalon in etalon {
                for variation in etalon.filterOptions {
                    for option in variation {
                        options.append(option)
                    }
                }
            }
            destination.options = options
            needReload = true
        }
    }
    
    
    
    
//MARK: metod
    func createImage(index:Int,_ cell:CellForShowcaseVC) {
        let url = etalon[index].imageURL
        cell.image.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "Image-5"))
        cell.image.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "Image-5")) { (response) in
            guard let data = response.data else { return }
            self.imageCache.add(UIImage(data: data)!, withIdentifier: self.etalon[index].imageURL.absoluteString)
        }
    }
    
    @objc fileprivate func addToCoreData(sender: UIButton) {
        guard let cell = sender.superview?.superview as? CellForShowcaseVC else { return }
        guard let index = myCollectionView.indexPath(for: cell) else { return }
        let context = appDelegate.persistentContainer.viewContext
        let values = isSearching || isSorted ? filtered : etalon
        if saveEtalon(index, context, etalon) {
            cell.likeButton.setTitleColor(.red, for: .normal)
            savedEtalonsId.append(values[index.row].id)
        } else {
            cell.likeButton.setTitleColor(.black, for: .normal)
            guard let savedIndex = savedEtalonsId.index(where: { (id) -> Bool in
                return id == values[index.row].id
            }) else { return }
            savedEtalonsId.remove(at: savedIndex)
        }
    }
    
    func filterOut() {
        filtered.removeAll(keepingCapacity: false)
        
        myCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        counterForElements = 20
        myCollectionView.reloadData()
        if filterOptions.count == 1 && filterOptions[0].uniqueKey == "Сортировка" {
            sort()
            return
        }
        for etalon in etalon {
            var needAdd = false
            if let index = filterOptions.index(where: { (option) -> Bool in
                return option.uniqueKey == "Подкатегория"
            }) {
                guard let categoryIndex = commodityCategory.index(where: { (category) -> Bool in
                    return category.id == etalon.categoryId
                }) else { continue }
                guard filterOptions[index].values.contains(commodityCategory[categoryIndex].name) else { continue }
            }
            for variation in etalon.filterOptions {
                guard variation.count >= filterOptions.count else { break }
                for filterOption in filterOptions {
                    guard filterOption.uniqueKey != "Сортировка" && filterOption.uniqueKey != "Подкатегория" else { continue }
                    needAdd = false
                    guard let index = variation.index(where: { (option) -> Bool in
                        return option.key == filterOption.uniqueKey
                    }) else { break }
                    
                    if let doubleValue = variation[index].value as? Double {
                        guard let from = filterOption.minValue, let to = filterOption.maxValue else { return }
                        guard doubleValue >= from && to >= doubleValue else { continue }
                        needAdd = true
                        continue
                    }
                    if let boolValue = variation[index].value as? Bool {
                        guard boolValue && filterOption.values[0] == "да" || !boolValue && filterOption.values[0] == "нет" else { continue }
                        needAdd = true
                        continue
                    }
                    
                    if let stringValue = variation[index].value as?  String {
                        guard filterOption.values.contains(where: { (value) -> Bool in
                            return value == stringValue.lowercased()
                        }) else { continue }
                        needAdd = true
                        continue
                    }
                }
                guard !needAdd else { break }
            }
            guard needAdd else { continue }
            filtered.append(etalon)
        }
        self.sort()
        self.myCollectionView.reloadData()
    }
    func sort() {
        guard let index = filterOptions.index(where: { (option) -> Bool in
            return option.uniqueKey == "Сортировка"
        }) else { return }
        var values = filtered
        if filterOptions.count == 1 {
            values = etalon
        }
        if filterOptions[index].values[0] == "По возрастанию цены" {
            filtered = values.sorted(by: { (a, b) -> Bool in
                return a.priceOptions[0].customerPrice < b.priceOptions[0].customerPrice
            })
        } else {
            filtered = values.sorted(by: { (a, b) -> Bool in
                return a.priceOptions[0].customerPrice > b.priceOptions[0].customerPrice
            })
        }
    }
}
//MARK: extension
extension ShowcaseVC:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = myCollectionView.frame.size.width
        let xInsents: CGFloat = 10
        let cellSpasing: CGFloat = 5
        return CGSize(width: (width/numberOfColumns) - (xInsents+cellSpasing), height: CGFloat(width/numberOfColumns) - (xInsents+cellSpasing)+50)
    }
}


