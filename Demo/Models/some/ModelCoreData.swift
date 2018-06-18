//
//  ModelCoreData.swift
//  Demo
//
//  Created by Admin on 12.05.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreData

func saveEtalon(_ index: IndexPath, _ context: NSManagedObjectContext, _ etalon: [Etalon]) -> Bool{
    let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EtalonCD")
    fetchedRequest.predicate = NSPredicate(format: "id == %i", etalon[index.row].id)
    do {
        let etalonFetch = try context.fetch(fetchedRequest) as! [EtalonCD]
        if etalonFetch.count != 0 {
            context.delete(etalonFetch[0])
            try context.save()
            return false
        }
        let etalonCoreData = EtalonCD(context: context)
        
        etalonCoreData.id = Int32(etalon[index.row].id)
        etalonCoreData.article = etalon[index.row].article
        etalonCoreData.categoryId = Int32(etalon[index.row].categoryId)
        etalonCoreData.desc = etalon[index.row].description
        etalonCoreData.imageURL = etalon[index.row].imageURL.absoluteString
        etalonCoreData.name = etalon[index.row].name
        etalonCoreData.pointId = Int32(etalon[index.row].terminal.pointId)
        etalonCoreData.showcaseId = Int32(etalon[index.row].terminal.showcaseId)
        etalonCoreData.vendorId = Int32(etalon[index.row].terminal.vendorId)
        etalonCoreData.city = etalon[index.row].terminal.distributionPoint.city
        etalonCoreData.streetName = etalon[index.row].terminal.distributionPoint.streetName
        etalonCoreData.streetNumber = etalon[index.row].terminal.distributionPoint.streetNumber
        etalonCoreData.vendorName = etalon[index.row].terminal.distributionPoint.vendorName
        
        for priceOption in etalon[index.row].priceOptions {
            let newPriceOption = PriceOptionCD(context: context)
            newPriceOption.price = priceOption.customerPrice
            newPriceOption.duration = priceOption.duration
            etalonCoreData.addToEtalonPrices(newPriceOption)
        }
        try context.save()
        return true
    } catch {
        print("can't save")
        return false
    }
}
