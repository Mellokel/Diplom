//
// SharedCommodityCategoriesAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class SharedCommodityCategoriesAPI {
    /**

     - parameter id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteCommodityCategory(id: Int, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteCommodityCategoryWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - DELETE /api/shared/commodity/categories/{id}
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     
     - parameter id: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func deleteCommodityCategoryWithRequestBuilder(id: Int) -> RequestBuilder<Void> {
        var path = "/api/shared/commodity/categories/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getCommodityCategories(completion: @escaping ((_ data: [CommodityCategoryGetApiModel]?,_ error: Error?) -> Void)) {
        getCommodityCategoriesWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /api/shared/commodity/categories
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example=[ {
  "ServiceFee" : {
    "Percentage" : 1.4658129805029452,
    "MaximumValue" : 5.637376656633329,
    "Id" : 6,
    "MinimumValue" : 5.962133916683182,
    "Name" : "Name"
  },
  "Fields" : [ {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  }, {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  } ],
  "NameSingular" : "NameSingular",
  "Id" : 0,
  "ConcurrencyToken" : "00000000-0000-0000-0000-000000000000",
  "Children" : [ null, null ],
  "Name" : "Name"
}, {
  "ServiceFee" : {
    "Percentage" : 1.4658129805029452,
    "MaximumValue" : 5.637376656633329,
    "Id" : 6,
    "MinimumValue" : 5.962133916683182,
    "Name" : "Name"
  },
  "Fields" : [ {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  }, {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  } ],
  "NameSingular" : "NameSingular",
  "Id" : 0,
  "ConcurrencyToken" : "00000000-0000-0000-0000-000000000000",
  "Children" : [ null, null ],
  "Name" : "Name"
} ]}]

     - returns: RequestBuilder<[CommodityCategoryGetApiModel]> 
     */
    open class func getCommodityCategoriesWithRequestBuilder() -> RequestBuilder<[CommodityCategoryGetApiModel]> {
        let path = "/api/shared/commodity/categories"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[CommodityCategoryGetApiModel]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getCommodityCategoriesPlain(completion: @escaping ((_ data: [CommodityCategoryGetSingleApiModel]?,_ error: Error?) -> Void)) {
        getCommodityCategoriesPlainWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /api/shared/commodity/categories/plain
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example=[ {
  "ParentId" : 6,
  "ServiceFee" : {
    "Percentage" : 1.4658129805029452,
    "MaximumValue" : 5.637376656633329,
    "Id" : 6,
    "MinimumValue" : 5.962133916683182,
    "Name" : "Name"
  },
  "Fields" : [ {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  }, {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  } ],
  "NameSingular" : "NameSingular",
  "Id" : 0,
  "ConcurrencyToken" : "00000000-0000-0000-0000-000000000000",
  "Name" : "Name"
}, {
  "ParentId" : 6,
  "ServiceFee" : {
    "Percentage" : 1.4658129805029452,
    "MaximumValue" : 5.637376656633329,
    "Id" : 6,
    "MinimumValue" : 5.962133916683182,
    "Name" : "Name"
  },
  "Fields" : [ {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  }, {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  } ],
  "NameSingular" : "NameSingular",
  "Id" : 0,
  "ConcurrencyToken" : "00000000-0000-0000-0000-000000000000",
  "Name" : "Name"
} ]}]

     - returns: RequestBuilder<[CommodityCategoryGetSingleApiModel]> 
     */
    open class func getCommodityCategoriesPlainWithRequestBuilder() -> RequestBuilder<[CommodityCategoryGetSingleApiModel]> {
        let path = "/api/shared/commodity/categories/plain"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[CommodityCategoryGetSingleApiModel]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getCommodityCategory(id: Int, completion: @escaping ((_ data: CommodityCategoryGetSingleApiModel?,_ error: Error?) -> Void)) {
        getCommodityCategoryWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /api/shared/commodity/categories/{id}
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example={
  "ParentId" : 6,
  "ServiceFee" : {
    "Percentage" : 1.4658129805029452,
    "MaximumValue" : 5.637376656633329,
    "Id" : 6,
    "MinimumValue" : 5.962133916683182,
    "Name" : "Name"
  },
  "Fields" : [ {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  }, {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  } ],
  "NameSingular" : "NameSingular",
  "Id" : 0,
  "ConcurrencyToken" : "00000000-0000-0000-0000-000000000000",
  "Name" : "Name"
}}]
     
     - parameter id: (path)  

     - returns: RequestBuilder<CommodityCategoryGetSingleApiModel> 
     */
    open class func getCommodityCategoryWithRequestBuilder(id: Int) -> RequestBuilder<CommodityCategoryGetSingleApiModel> {
        var path = "/api/shared/commodity/categories/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<CommodityCategoryGetSingleApiModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter model: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func postCommodityCategory(model: CommodityCategoryCreateApiModel, completion: @escaping ((_ data: CommodityCategoryGetSingleApiModel?,_ error: Error?) -> Void)) {
        postCommodityCategoryWithRequestBuilder(model: model).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - POST /api/shared/commodity/categories
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example={
  "ParentId" : 6,
  "ServiceFee" : {
    "Percentage" : 1.4658129805029452,
    "MaximumValue" : 5.637376656633329,
    "Id" : 6,
    "MinimumValue" : 5.962133916683182,
    "Name" : "Name"
  },
  "Fields" : [ {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  }, {
    "Field" : {
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
    },
    "IsInherited" : true,
    "IsSelectable" : true,
    "IsDisplayable" : true,
    "IsPerVariation" : true
  } ],
  "NameSingular" : "NameSingular",
  "Id" : 0,
  "ConcurrencyToken" : "00000000-0000-0000-0000-000000000000",
  "Name" : "Name"
}}]
     
     - parameter model: (body)  

     - returns: RequestBuilder<CommodityCategoryGetSingleApiModel> 
     */
    open class func postCommodityCategoryWithRequestBuilder(model: CommodityCategoryCreateApiModel) -> RequestBuilder<CommodityCategoryGetSingleApiModel> {
        let path = "/api/shared/commodity/categories"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<CommodityCategoryGetSingleApiModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**

     - parameter id: (path)  
     - parameter model: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func putCommodityCategory(id: Int, model: CommodityCategoryUpdateApiModel, completion: @escaping ((_ error: Error?) -> Void)) {
        putCommodityCategoryWithRequestBuilder(id: id, model: model).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - PUT /api/shared/commodity/categories/{id}
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     
     - parameter id: (path)  
     - parameter model: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func putCommodityCategoryWithRequestBuilder(id: Int, model: CommodityCategoryUpdateApiModel) -> RequestBuilder<Void> {
        var path = "/api/shared/commodity/categories/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
