//
//  Helper.swift
//  Demo
//
//  Created by Admin on 13.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation



public struct Category {
    var id: Int = 0
    var name: String = ""
}

public struct Terminal {
    var vendorId:Int = 0
    var pointId:Int = 0
    var showcaseId:Int = 0
    var distributionPoint = DistributionPoint()
}

public struct PriceOption {
    var customerPrice:Double = 0
    var duration: String = ""
}
public struct Etalon{
    var id:Int = 0
    var article:String = ""
    var description: String = ""
    var imageURL = URL(fileURLWithPath: "")
    var name:String = ""
    var categoryId:Int = 0
    var terminal = Terminal()
    var priceOptions:[PriceOption] = []
    var filterOptions:[[Option]] = []
}

public var terminals:[Terminal] = []
public var terminalFiltred:[Terminal] = []
var commodityCategory:[Category] = []

//MARK: methods
open class Helper {
    open class func getEtalons(seviceFeeNumber: Int, completion: @escaping ((_ data: [EtalonWithVariationsAndPricesGetApiModel]?,_ commodityCategory:[Category],_ terminalId:Terminal,_ error: Error?) -> Void)){
        commodityCategory = []
        SharedCommodityCategoriesAPI.getCommodityCategories { (response, error) in
            guard let response = response else { return }
            for element in response {
                guard let serviceFee = element.serviceFee else { continue }
                guard let serviceId = serviceFee.id else { continue }
                guard serviceId == seviceFeeNumber else { continue }
                guard let name = element.name else { continue }
                guard let id = element.id else { continue }
                guard let children = element.children else { continue }
                commodityCategory.append(Category(id: id, name: name))
                findCategoryIds(childrens: children)
            }
        }
        terminals = []
        MeAPI.getMe { (response, error) in
            guard let response = response else { return }
            guard let access = response.access else { return }
            guard let terminal = access.terminal else { return }
            guard let currentTerminals = terminal.terminals else { return }
            for element in currentTerminals{
                guard let vendor = element.vendor else { continue }
                guard let vendorId = vendor.id else { continue }
                guard let vendorName = vendor.name else { continue }
                guard let distributionPoint = element.distributionPoint else { continue }
                guard let distributionPointId = distributionPoint.id  else { continue }
                guard let distributionPointCity = distributionPoint.city  else { continue }
                guard let distributionPointstreetName = distributionPoint.streetName  else { continue }
                guard let distributionPointStreetNumber = distributionPoint.streetNumber  else { continue }
                
                VendorDistributionPointShowcasesAPI.getVendorDistributionPointShowcases(vendorId: vendorId, pointId: distributionPointId, completion: { (showcases, error) in
                    guard let showcases = showcases else { return }
                    for showcase in showcases{
                        guard let showcaseId = showcase.id else { continue }
                        var terminal = Terminal()
                        terminal.pointId = distributionPointId
                        terminal.vendorId = vendorId
                        terminal.showcaseId = showcaseId
                        terminal.distributionPoint = DistributionPoint(vendorName: vendorName, city: distributionPointCity, streetName: distributionPointstreetName, streetNumber: distributionPointStreetNumber, location: nil)
                        terminals.append(terminal)
                        VendorDistributionPointShowcaseEtalonsAPI.getVendorDistributionPointShowcaseDetailedEtalons(vendorId: vendorId, pointId: distributionPointId, showcaseId: showcaseId, completion: { (etalons, error) in
                            completion(etalons, commodityCategory,terminal,error)
                        })
                    }
                })
            }
        }
    }
    open class func findCategoryIds (childrens: [CommodityCategoryGetApiModel]) {
        for element in childrens {
            guard let children = element.children else { continue }
            if !children.isEmpty {
                self.findCategoryIds(childrens: children)
            } else {
                guard let id = element.id else { continue }
                guard let name = element.name else { continue }
                commodityCategory.append(Category(id: id, name: name))
            }
        }
    }
    
    open class func getImagesUrl (identifiers:UploadImageResolveApiModel, completion:  @escaping (_ article: String, _ url: URL) -> Void, endOfFunc:  @escaping () -> Void) {
        UploadAPI.postResolveImage(model: identifiers, completion: { (images, error) in
            guard let images = images else  { return }
            for image in images {
                guard let variations = image.variations else { return }
                guard let variation300 = variations.first(where: { (variation) -> Bool in
                    return variation.id == "300"
                }) else { return }
                guard let path = variation300.path else { return }
                guard let url = URL(string: path) else { return }
                guard let article = image.originalName else { return }
                completion(article, url)
            }
            endOfFunc()
        })
    }
}
