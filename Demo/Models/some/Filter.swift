//
//  Sort.swift
//  Demo
//
//  Created by Admin on 14.02.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
var filterOptions:[FilterOption] = []

public struct FilterOption {
    var uniqueKey: String = ""
    var values: [String] = []
    var minValue: Double?
    var maxValue: Double?
}

open class Filter {
    open class func appendFilterOption(uniqueKey:String, values: [String]){
        clearFilterOption(uniqueKey: uniqueKey)
        filterOptions.append(FilterOption(uniqueKey: uniqueKey, values: values,minValue: nil,maxValue: nil))
    }
    open class func appendFilterOption(uniqueKey:String, minValue:Double, maxValue:Double ){
        clearFilterOption(uniqueKey: uniqueKey)
        filterOptions.append(FilterOption(uniqueKey: uniqueKey, values: [],minValue: minValue,maxValue: maxValue))
    }
    open class func getFilterOptions() -> [FilterOption]{
        return filterOptions
    }
    open class func clearFilter(){
        filterOptions.removeAll()
    }
    open class func clearFilterOption(uniqueKey: String){
        if let index = filterOptions.index(where: { (option) -> Bool in
            return option.uniqueKey == uniqueKey
        }) {
            filterOptions.remove(at: index)
        }
    }
}


























