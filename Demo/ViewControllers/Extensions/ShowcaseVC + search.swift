//
//  ShowcaseVC + search.swift
//  Demo
//
//  Created by Admin on 22.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

extension ShowcaseVC:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let predicateString = searchBar.text!
        guard predicateString != "" else { return }
        
        for etalon in etalon {
            guard etalon.article.range(of: predicateString) != nil else { continue }
            filtered.append(etalon)
            myCollectionView.reloadData()
        }
        
        isSearching = (filtered.count == 0) ? false : true
    }
    func  searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered.removeAll(keepingCapacity: false)
        
        if let predicateString = searchBar.text {
            isSorted = false
            if predicateString == ""{
                isSearching = false
                myCollectionView.reloadData()
            }
        } else {
            isSearching = false
            myCollectionView.reloadData()
        }
        
    }
}
