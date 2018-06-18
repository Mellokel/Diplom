//
//  ModelForCamera.swift
//  Demo
//
//  Created by Admin on 15.05.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class ModelForCamera {

    var terminals:[CurrentUserTerminalEntityApiModel] = []
    var showcases:[ShowcaseGetApiModel] = []
    
    var currentTerminalNumber = 0
    var currentShowcaseNumber = 0
    
    var code: String = ""
    var completion:  ((Etalon) -> Void)?
    var errorCompletion: ((Bool) -> Void)?
    
    fileprivate func getEtalons(_ terminal: Terminal) {
        var terminal = terminal
        guard self.showcases.count >= self.currentShowcaseNumber + 1 else { return }
        let showcase = self.showcases[self.currentShowcaseNumber]
        guard let showcaseId = showcase.id else {
            self.currentShowcaseNumber += 1
            getEtalons(terminal)
            return
        }
        terminal.showcaseId = showcaseId

        VendorDistributionPointShowcaseEtalonsAPI.getVendorDistributionPointShowcaseEtalons(vendorId: terminal.vendorId, pointId: terminal.pointId, showcaseId: showcaseId, completion: { (etalons, error) in
            
            guard let etalons = etalons else { return }
            guard let index = etalons.index(where: { (element) -> Bool in
                guard let qrcode = element.qRCodeImageId else { return false }
                print(self.code)
                print(qrcode.uuidString.lowercased())
                return qrcode.uuidString.lowercased() == self.code
            }) else { return }
            guard let id = etalons[index].etalon?.id else { return }
            self.currentShowcaseNumber = self.showcases.count + 1
            self.currentTerminalNumber = self.terminals.count + 1
            VendorDistributionPointShowcaseEtalonsAPI.getVendorDistributionPointShowcaseDetailedEtalons(vendorId: terminal.vendorId, pointId: terminal.pointId, showcaseId: showcaseId, completion: { (detailed, error) in
                guard let detailed = detailed else { return }
                guard let newIndex = etalons.index(where: { (element) -> Bool in
                    guard let currentId = element.etalon?.id else { return false }
                    return id == currentId
                }) else { return }
                
                var newEtalon = Etalon()
                let etalon = detailed[newIndex]
                guard let article = etalon.article else {
                    self.errorCompletion!(true)
                    return
                }
                guard let commodityCategoryId = etalon.commodityCategoryId else {
                    self.errorCompletion!(true)
                    return
                }
                
                guard let imageId = etalon.imageId else {
                    self.errorCompletion!(true)
                    return
                }
                
                newEtalon.id = id
                newEtalon.article = article
                newEtalon.categoryId = commodityCategoryId
                if let description = etalon.description {
                    newEtalon.description = description
                }
                newEtalon.terminal = terminal
                
                guard let variations = etalon.variations else {
                    self.errorCompletion!(true)
                    return
                }
                guard let variation = variations.first else {
                    self.errorCompletion!(true)
                    return
                }
                guard let priceOptions = variation.priceOptions else {
                    self.errorCompletion!(true)
                    return
                }
                for variationPriceOption in priceOptions {
                    guard let customerPrice = variationPriceOption.customerPrice else { continue }
                    guard let duration = variationPriceOption.duration else { continue }
                    newEtalon.priceOptions.append(PriceOption(customerPrice: customerPrice, duration: duration))
                }
                
                let identifire = UploadImageResolveApiModel(identifiers: [imageId])
                Helper.getImagesUrl(identifiers: identifire, completion: { (_, url) in
                    newEtalon.imageURL = url
                    self.completion!(newEtalon)
                }, endOfFunc: {})
                
            })
        })
        self.currentShowcaseNumber += 1
        getEtalons(terminal)
    }

    fileprivate func getShowcase(_ vendorId: Int, _ distributionPointId: Int, _ vendorName: String, _ distributionPointCity: String, _ distributionPointstreetName: String, _ distributionPointStreetNumber: String) {
        VendorDistributionPointShowcasesAPI.getVendorDistributionPointShowcases(vendorId: vendorId, pointId: distributionPointId, completion: { (showcases, error2) in
            // guard !needStop else { return }
            guard let showcases = showcases else {
                self.getShowcases()
                return
            }
            self.showcases = showcases
            self.currentShowcaseNumber = 0
            var terminal = Terminal()
            terminal.pointId = distributionPointId
            terminal.vendorId = vendorId
            
            terminal.distributionPoint = DistributionPoint(vendorName: vendorName, city: distributionPointCity, streetName: distributionPointstreetName, streetNumber: distributionPointStreetNumber, location: nil)
            
            self.getEtalons(terminal)
        })
    }

    fileprivate func getShowcases() {

        guard self.terminals.count >= self.currentTerminalNumber + 1 else { return }
        let element = terminals[self.currentTerminalNumber]
        guard let vendor = element.vendor else {
            self.currentTerminalNumber += 1
            getShowcases()
            return
            }
        guard let vendorId = vendor.id else {
            self.currentTerminalNumber += 1
            getShowcases()
            return
        }
        guard let vendorName = vendor.name else {
            self.currentTerminalNumber += 1
            getShowcases()
            return
        }
        guard let distributionPoint = element.distributionPoint else {
            self.currentTerminalNumber += 1
            getShowcases()
        return
        }
        guard let distributionPointId = distributionPoint.id  else {
            self.currentTerminalNumber += 1
            getShowcases()
            return
        }
        guard let distributionPointCity = distributionPoint.city  else {
            self.currentTerminalNumber += 1
            getShowcases()
            return
        }
        guard let distributionPointstreetName = distributionPoint.streetName  else {
            self.currentTerminalNumber += 1
            getShowcases()
            return
        }
        guard let distributionPointStreetNumber = distributionPoint.streetNumber  else {
            self.currentTerminalNumber += 1
            getShowcases()
            return
        }

        getShowcase(vendorId, distributionPointId, vendorName, distributionPointCity, distributionPointstreetName, distributionPointStreetNumber)
        self.currentTerminalNumber += 1
        getShowcases()
    }
}
func findEtalon(withQRcode code: String, completion: @escaping((_ etalon: Etalon) -> Void),errorCompletion: @escaping((_ error: Bool) -> Void)) {
    
    let model = ModelForCamera()
    MeAPI.getMe { (response, error1) in
        guard let response = response else { return }
        guard let access = response.access else { return }
        guard let terminal = access.terminal else { return }
        guard let currentTerminals = terminal.terminals else { return }
        model.terminals = currentTerminals
        model.completion = completion
        model.code = code
        model.errorCompletion = errorCompletion
        model.getShowcases()
    }
}
