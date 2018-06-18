//
// SharedCommodityOptionFieldsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class SharedCommodityOptionFieldsAPI {
    /**

     - parameter id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteCommodityOptionField(id: Int, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteCommodityOptionFieldWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - DELETE /api/shared/commodity/fields/{id}
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     
     - parameter id: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func deleteCommodityOptionFieldWithRequestBuilder(id: Int) -> RequestBuilder<Void> {
        var path = "/api/shared/commodity/fields/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getCommodityOptionField(id: Int, completion: @escaping ((_ data: CommodityOptionFieldGetApiModel?,_ error: Error?) -> Void)) {
        getCommodityOptionFieldWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /api/shared/commodity/fields/{id}
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example={
  "MeasurementUnit" : {
    "ShortName" : "ShortName",
    "Id" : 7,
    "Name" : "Name"
  },
  "Type" : "String",
  "Parameters" : {
    "key" : "{}"
  },
  "UniqueKey" : "UniqueKey",
  "Id" : 2,
  "ConcurrencyToken" : "00000000-0000-0000-0000-000000000000",
  "Name" : "Name"
}}]
     
     - parameter id: (path)  

     - returns: RequestBuilder<CommodityOptionFieldGetApiModel> 
     */
    open class func getCommodityOptionFieldWithRequestBuilder(id: Int) -> RequestBuilder<CommodityOptionFieldGetApiModel> {
        var path = "/api/shared/commodity/fields/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<CommodityOptionFieldGetApiModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getCommodityOptionFields(completion: @escaping ((_ data: [CommodityOptionFieldGetApiModel]?,_ error: Error?) -> Void)) {
        getCommodityOptionFieldsWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /api/shared/commodity/fields
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example=[ {
  "MeasurementUnit" : {
    "ShortName" : "ShortName",
    "Id" : 7,
    "Name" : "Name"
  },
  "Type" : "String",
  "Parameters" : {
    "key" : "{}"
  },
  "UniqueKey" : "UniqueKey",
  "Id" : 2,
  "ConcurrencyToken" : "00000000-0000-0000-0000-000000000000",
  "Name" : "Name"
}, {
  "MeasurementUnit" : {
    "ShortName" : "ShortName",
    "Id" : 7,
    "Name" : "Name"
  },
  "Type" : "String",
  "Parameters" : {
    "key" : "{}"
  },
  "UniqueKey" : "UniqueKey",
  "Id" : 2,
  "ConcurrencyToken" : "00000000-0000-0000-0000-000000000000",
  "Name" : "Name"
} ]}]

     - returns: RequestBuilder<[CommodityOptionFieldGetApiModel]> 
     */
    open class func getCommodityOptionFieldsWithRequestBuilder() -> RequestBuilder<[CommodityOptionFieldGetApiModel]> {
        let path = "/api/shared/commodity/fields"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[CommodityOptionFieldGetApiModel]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter model: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func postCommodityOptionField(model: CommodityOptionFieldEditApiModel, completion: @escaping ((_ data: [CommodityOptionFieldGetApiModel]?,_ error: Error?) -> Void)) {
        postCommodityOptionFieldWithRequestBuilder(model: model).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - POST /api/shared/commodity/fields
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example=[ {
  "MeasurementUnit" : {
    "ShortName" : "ShortName",
    "Id" : 7,
    "Name" : "Name"
  },
  "Type" : "String",
  "Parameters" : {
    "key" : "{}"
  },
  "UniqueKey" : "UniqueKey",
  "Id" : 2,
  "ConcurrencyToken" : "00000000-0000-0000-0000-000000000000",
  "Name" : "Name"
}, {
  "MeasurementUnit" : {
    "ShortName" : "ShortName",
    "Id" : 7,
    "Name" : "Name"
  },
  "Type" : "String",
  "Parameters" : {
    "key" : "{}"
  },
  "UniqueKey" : "UniqueKey",
  "Id" : 2,
  "ConcurrencyToken" : "00000000-0000-0000-0000-000000000000",
  "Name" : "Name"
} ]}]
     
     - parameter model: (body)  

     - returns: RequestBuilder<[CommodityOptionFieldGetApiModel]> 
     */
    open class func postCommodityOptionFieldWithRequestBuilder(model: CommodityOptionFieldEditApiModel) -> RequestBuilder<[CommodityOptionFieldGetApiModel]> {
        let path = "/api/shared/commodity/fields"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[CommodityOptionFieldGetApiModel]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**

     - parameter id: (path)  
     - parameter model: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func putCommodityOptionField(id: Int, model: CommodityOptionFieldEditApiModel, completion: @escaping ((_ error: Error?) -> Void)) {
        putCommodityOptionFieldWithRequestBuilder(id: id, model: model).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - PUT /api/shared/commodity/fields/{id}
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     
     - parameter id: (path)  
     - parameter model: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func putCommodityOptionFieldWithRequestBuilder(id: Int, model: CommodityOptionFieldEditApiModel) -> RequestBuilder<Void> {
        var path = "/api/shared/commodity/fields/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}