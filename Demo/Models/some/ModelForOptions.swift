//
//  ModelForOptions.swift
//  Demo
//
//  Created by Admin on 15.05.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

public struct Field {
    var name: String = ""
    var uniqueKey: String = ""
    var type: String = ""
    var isMeasurable: Bool = false
    var minValue: Double?
    var maxValue: Double?
    var stringValues: [String]?
}
public struct Option {
    var key = ""
    var value: Any
}
