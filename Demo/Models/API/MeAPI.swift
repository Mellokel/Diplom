//
// MeAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class MeAPI {
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getMe(completion: @escaping ((_ data: CurrentUserApiModel?,_ error: Error?) -> Void)) {
        getMeWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /api/me
     - OAuth:
       - type: oauth2
       - name: tokenAuth
     - examples: [{contentType=application/json, example={
  "UserName" : "UserName",
  "Access" : {
    "SupplierUser" : {
      "Suppliers" : [ {
        "Id" : 0,
        "Name" : "Name"
      }, {
        "Id" : 0,
        "Name" : "Name"
      } ],
      "Granted" : true
    },
    "Administrator" : {
      "Granted" : true
    },
    "Supplier" : {
      "Suppliers" : [ {
        "Id" : 0,
        "Name" : "Name"
      }, {
        "Id" : 0,
        "Name" : "Name"
      } ],
      "Granted" : true
    },
    "Vendor" : {
      "Vendors" : [ {
        "Id" : 6,
        "Name" : "Name"
      }, {
        "Id" : 6,
        "Name" : "Name"
      } ],
      "Granted" : true
    },
    "Terminal" : {
      "Granted" : true,
      "Terminals" : [ {
        "Id" : 1,
        "Vendor" : {
          "Id" : 6,
          "Name" : "Name"
        },
        "DistributionPoint" : {
          "StreetName" : "StreetName",
          "StreetNumber" : "StreetNumber",
          "Id" : 5,
          "City" : "City"
        }
      }, {
        "Id" : 1,
        "Vendor" : {
          "Id" : 6,
          "Name" : "Name"
        },
        "DistributionPoint" : {
          "StreetName" : "StreetName",
          "StreetNumber" : "StreetNumber",
          "Id" : 5,
          "City" : "City"
        }
      } ]
    }
  }
}}]

     - returns: RequestBuilder<CurrentUserApiModel> 
     */
    open class func getMeWithRequestBuilder() -> RequestBuilder<CurrentUserApiModel> {
        let path = "/api/me"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<CurrentUserApiModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
