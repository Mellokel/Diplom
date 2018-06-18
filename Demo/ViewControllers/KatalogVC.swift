//
//  File.swift
//  Demo
//
//  Created by Admin on 07.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class KatalogVC : UICollectionViewController{
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    var serviceFees:[Service] = []
    
    public struct Service {
        var id = 0
        var name = ""
    }
    
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard serviceFees.count == 0 else { return }
        SharedServiceFeesAPI.getServiceFees{ (response, error) in
            guard let response = response else { return }
            for i in response{
                guard let id = i.id else { return }
                self.serviceFees.append(Service(id: id, name: i.name))
            }
            self.myCollectionView.reloadData()
        }
    }
    
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellForKatalogVC
        cell.lableName.text = serviceFees[indexPath.row].name
        cell.image.image = #imageLiteral(resourceName: "Image-5")
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceFees.count != 0 ? 1 : 0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination: ShowcaseVC = segue.destination as! ShowcaseVC
        let index = collectionView?.indexPathsForSelectedItems
        destination.seviceFeeNumber = serviceFees[index![0].row].id
        destination.seviceFeeName = serviceFees[index![0].row].name
    }
}

extension KatalogVC:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = myCollectionView.frame.size.width
        let xInsents: CGFloat = 10
        let cellSpasing: CGFloat = 5
        return CGSize(width: (width/numberOfColumns) - (xInsents+cellSpasing), height: CGFloat(width/numberOfColumns) - (xInsents+cellSpasing)+100)
    }
}
