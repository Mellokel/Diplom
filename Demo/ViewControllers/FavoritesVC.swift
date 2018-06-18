//
//  FavoritesVC.swift
//  Demo
//
//  Created by Admin on 09.05.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreData
import AlamofireImage

class FavoritesVC: UICollectionViewController {
    
    var etalons:[Etalon] = []
    
    let imageCache = AutoPurgingImageCache()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        etalons = []
        let context = appDelegate.persistentContainer.viewContext
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EtalonCD")
        do {
            let etalonFetch = try context.fetch(fetchedRequest) as! [EtalonCD]
            for etalon in etalonFetch {
                var newEtalon = Etalon()
                newEtalon.id = Int(etalon.id)
                newEtalon.article = etalon.article!
                newEtalon.categoryId = Int(etalon.categoryId)
                newEtalon.description = etalon.desc!
                newEtalon.imageURL = URL(string: etalon.imageURL!)!
                newEtalon.name = etalon.name!
                newEtalon.terminal.vendorId = Int(etalon.vendorId)
                newEtalon.terminal.showcaseId = Int(etalon.showcaseId)
                newEtalon.terminal.pointId = Int(etalon.pointId)
                newEtalon.terminal.distributionPoint.city = etalon.city!
                newEtalon.terminal.distributionPoint.streetName = etalon.streetName!
                newEtalon.terminal.distributionPoint.streetNumber = etalon.streetNumber!
                newEtalon.terminal.distributionPoint.vendorName = etalon.vendorName!
                let array = etalon.etalonPrices?.array as! [PriceOptionCD]
                for option in array{
                    newEtalon.priceOptions.append(PriceOption(customerPrice: option.price, duration: option.duration!))
                }
                etalons.append(newEtalon)
            }
            collectionView?.reloadData()
        } catch {
            print("error")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellForShowcaseVC
        cell.article.text = nil
        cell.price.text = nil
        cell.image.image = nil
        
        cell.article.text = etalons[indexPath.row].article
        cell.price.text = String(etalons[indexPath.row].priceOptions[0].customerPrice)
        cell.likeButton.addTarget(self, action: #selector(deleteFromCoreData(sender:)), for: .touchUpInside)
        cell.likeButton.setTitleColor(.red, for: .normal)
        if let image = imageCache.image(withIdentifier: etalons[indexPath.row].imageURL.absoluteString) {
            cell.image.image = image
        } else {
            self.createImage(index: indexPath.row,cell)
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return etalons.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EtalonVC {
            let indexPath = self.collectionView?.indexPathsForSelectedItems
            destination.etalon = etalons[indexPath![0].row]
        }
    }
    @objc fileprivate func deleteFromCoreData(sender: UIButton) {
        guard let cell = sender.superview?.superview as? CellForShowcaseVC else { return }
        guard let index = collectionView?.indexPath(for: cell) else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EtalonCD")
        fetchedRequest.predicate = NSPredicate(format: "id == %i", etalons[index.row].id)
        do {
            let etalonFetch = try context.fetch(fetchedRequest) as! [EtalonCD]
            guard etalonFetch.count != 0 else { return }
            context.delete(etalonFetch[0])
            etalons.remove(at: index.row)
            collectionView?.reloadData()
            try context.save()
        } catch {
            print("can't delete")
        }
    }
    func createImage(index:Int,_ cell:CellForShowcaseVC) {
        let url = etalons[index].imageURL
        cell.image.af_setImage(withURL: url)
        guard let image = cell.image.image else { return }
        imageCache.add(image, withIdentifier: etalons[index].imageURL.absoluteString)
    }
}
extension FavoritesVC:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = collectionView.frame.size.width
        let xInsents: CGFloat = 10
        let cellSpasing: CGFloat = 5
        return CGSize(width: (width/numberOfColumns) - (xInsents+cellSpasing), height: CGFloat(width/numberOfColumns) - (xInsents+cellSpasing)+50)
    }
}
