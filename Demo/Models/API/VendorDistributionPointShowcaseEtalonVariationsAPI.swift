//
// VendorDistributionPointShowcaseEtalonVariationsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class VendorDistributionPointShowcaseEtalonVariationsAPI {
    /**

     - parameter vendorId: (path)  
     - parameter pointId: (path)  
     - parameter showcaseId: (path)  
     - parameter etalonId: (path)  
     - parameter id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getVendorDistributionPointShowcaseEtalonVariation(vendorId: Int, pointId: Int, showcaseId: Int, etalonId: Int, id: Int, completion: @escaping ((_ data: EtalonVariationGetApiModel?,_ error: Error?) -> Void)) {
        getVendorDistributionPointShowcaseEtalonVariationWithRequestBuilder(vendorId: vendorId, pointId: pointId, showcaseId: showcaseId, etalonId: etalonId, id: id).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /api/vendors/{vendorId}/distributionpoints/{pointId}/showcases/{showcaseId}/etalons/{etalonId}/variations/{id}
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example={
  "Options" : {
    "key" : "{}"
  },
  "Description" : "Description",
  "Price" : 6.027456183070403,
  "Production" : true,
  "InnerId" : "InnerId",
  "Id" : 0,
  "DateAdded" : "2000-01-23T04:56:07.000+00:00",
  "Reserved" : true
}}]
     
     - parameter vendorId: (path)  
     - parameter pointId: (path)  
     - parameter showcaseId: (path)  
     - parameter etalonId: (path)  
     - parameter id: (path)  

     - returns: RequestBuilder<EtalonVariationGetApiModel> 
     */
    open class func getVendorDistributionPointShowcaseEtalonVariationWithRequestBuilder(vendorId: Int, pointId: Int, showcaseId: Int, etalonId: Int, id: Int) -> RequestBuilder<EtalonVariationGetApiModel> {
        var path = "/api/vendors/{vendorId}/distributionpoints/{pointId}/showcases/{showcaseId}/etalons/{etalonId}/variations/{id}"
        path = path.replacingOccurrences(of: "{vendorId}", with: "\(vendorId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{pointId}", with: "\(pointId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{showcaseId}", with: "\(showcaseId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{etalonId}", with: "\(etalonId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<EtalonVariationGetApiModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter vendorId: (path)  
     - parameter pointId: (path)  
     - parameter showcaseId: (path)  
     - parameter etalonId: (path)  
     - parameter id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getVendorDistributionPointShowcaseEtalonVariationAllPrices(vendorId: Int, pointId: Int, showcaseId: Int, etalonId: Int, id: Int, completion: @escaping ((_ data: EtalonVariationPriceApiModel?,_ error: Error?) -> Void)) {
        getVendorDistributionPointShowcaseEtalonVariationAllPricesWithRequestBuilder(vendorId: vendorId, pointId: pointId, showcaseId: showcaseId, etalonId: etalonId, id: id).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /api/vendors/{vendorId}/distributionpoints/{pointId}/showcases/{showcaseId}/etalons/{etalonId}/variations/{id}/prices/all
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example={
  "StartingDate" : "2000-01-23T04:56:07.000+00:00",
  "Options" : [ {
    "Duration" : "Duration",
    "Id" : "Id",
    "Hash" : "Hash",
    "CompletionDate" : "2000-01-23T04:56:07.000+00:00",
    "CustomerPrice" : 6.027456183070403,
    "Tags" : "Tags"
  }, {
    "Duration" : "Duration",
    "Id" : "Id",
    "Hash" : "Hash",
    "CompletionDate" : "2000-01-23T04:56:07.000+00:00",
    "CustomerPrice" : 6.027456183070403,
    "Tags" : "Tags"
  } ],
  "CalculationTime" : 0.8008281904610115,
  "CalculationPrecision" : "CalculationPrecision"
}}]
     
     - parameter vendorId: (path)  
     - parameter pointId: (path)  
     - parameter showcaseId: (path)  
     - parameter etalonId: (path)  
     - parameter id: (path)  

     - returns: RequestBuilder<EtalonVariationPriceApiModel> 
     */
    open class func getVendorDistributionPointShowcaseEtalonVariationAllPricesWithRequestBuilder(vendorId: Int, pointId: Int, showcaseId: Int, etalonId: Int, id: Int) -> RequestBuilder<EtalonVariationPriceApiModel> {
        var path = "/api/vendors/{vendorId}/distributionpoints/{pointId}/showcases/{showcaseId}/etalons/{etalonId}/variations/{id}/prices/all"
        path = path.replacingOccurrences(of: "{vendorId}", with: "\(vendorId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{pointId}", with: "\(pointId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{showcaseId}", with: "\(showcaseId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{etalonId}", with: "\(etalonId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<EtalonVariationPriceApiModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter vendorId: (path)  
     - parameter pointId: (path)  
     - parameter showcaseId: (path)  
     - parameter etalonId: (path)  
     - parameter id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getVendorDistributionPointShowcaseEtalonVariationPrices(vendorId: Int, pointId: Int, showcaseId: Int, etalonId: Int, id: Int, completion: @escaping ((_ data: EtalonVariationPriceApiModel?,_ error: Error?) -> Void)) {
        getVendorDistributionPointShowcaseEtalonVariationPricesWithRequestBuilder(vendorId: vendorId, pointId: pointId, showcaseId: showcaseId, etalonId: etalonId, id: id).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /api/vendors/{vendorId}/distributionpoints/{pointId}/showcases/{showcaseId}/etalons/{etalonId}/variations/{id}/prices
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example={
  "StartingDate" : "2000-01-23T04:56:07.000+00:00",
  "Options" : [ {
    "Duration" : "Duration",
    "Id" : "Id",
    "Hash" : "Hash",
    "CompletionDate" : "2000-01-23T04:56:07.000+00:00",
    "CustomerPrice" : 6.027456183070403,
    "Tags" : "Tags"
  }, {
    "Duration" : "Duration",
    "Id" : "Id",
    "Hash" : "Hash",
    "CompletionDate" : "2000-01-23T04:56:07.000+00:00",
    "CustomerPrice" : 6.027456183070403,
    "Tags" : "Tags"
  } ],
  "CalculationTime" : 0.8008281904610115,
  "CalculationPrecision" : "CalculationPrecision"
}}]
     
     - parameter vendorId: (path)  
     - parameter pointId: (path)  
     - parameter showcaseId: (path)  
     - parameter etalonId: (path)  
     - parameter id: (path)  

     - returns: RequestBuilder<EtalonVariationPriceApiModel> 
     */
    open class func getVendorDistributionPointShowcaseEtalonVariationPricesWithRequestBuilder(vendorId: Int, pointId: Int, showcaseId: Int, etalonId: Int, id: Int) -> RequestBuilder<EtalonVariationPriceApiModel> {
        var path = "/api/vendors/{vendorId}/distributionpoints/{pointId}/showcases/{showcaseId}/etalons/{etalonId}/variations/{id}/prices"
        path = path.replacingOccurrences(of: "{vendorId}", with: "\(vendorId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{pointId}", with: "\(pointId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{showcaseId}", with: "\(showcaseId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{etalonId}", with: "\(etalonId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<EtalonVariationPriceApiModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter vendorId: (path)  
     - parameter pointId: (path)  
     - parameter showcaseId: (path)  
     - parameter etalonId: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getVendorDistributionPointShowcaseEtalonVariations(vendorId: Int, pointId: Int, showcaseId: Int, etalonId: Int, completion: @escaping ((_ data: [EtalonVariationGetApiModel]?,_ error: Error?) -> Void)) {
        getVendorDistributionPointShowcaseEtalonVariationsWithRequestBuilder(vendorId: vendorId, pointId: pointId, showcaseId: showcaseId, etalonId: etalonId).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /api/vendors/{vendorId}/distributionpoints/{pointId}/showcases/{showcaseId}/etalons/{etalonId}/variations
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example=[ {
  "Options" : {
    "key" : "{}"
  },
  "Description" : "Description",
  "Price" : 6.027456183070403,
  "Production" : true,
  "InnerId" : "InnerId",
  "Id" : 0,
  "DateAdded" : "2000-01-23T04:56:07.000+00:00",
  "Reserved" : true
}, {
  "Options" : {
    "key" : "{}"
  },
  "Description" : "Description",
  "Price" : 6.027456183070403,
  "Production" : true,
  "InnerId" : "InnerId",
  "Id" : 0,
  "DateAdded" : "2000-01-23T04:56:07.000+00:00",
  "Reserved" : true
} ]}]
     
     - parameter vendorId: (path)  
     - parameter pointId: (path)  
     - parameter showcaseId: (path)  
     - parameter etalonId: (path)  

     - returns: RequestBuilder<[EtalonVariationGetApiModel]> 
     */
    open class func getVendorDistributionPointShowcaseEtalonVariationsWithRequestBuilder(vendorId: Int, pointId: Int, showcaseId: Int, etalonId: Int) -> RequestBuilder<[EtalonVariationGetApiModel]> {
        var path = "/api/vendors/{vendorId}/distributionpoints/{pointId}/showcases/{showcaseId}/etalons/{etalonId}/variations"
        path = path.replacingOccurrences(of: "{vendorId}", with: "\(vendorId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{pointId}", with: "\(pointId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{showcaseId}", with: "\(showcaseId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{etalonId}", with: "\(etalonId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[EtalonVariationGetApiModel]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}