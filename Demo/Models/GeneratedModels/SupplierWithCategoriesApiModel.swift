//
// SupplierWithCategoriesApiModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class SupplierWithCategoriesApiModel: Codable {

    public var id: Int?
    public var companyName: String?
    public var categories: [SupplierCategoryGetApiModel]?


    
    public init(id: Int?, companyName: String?, categories: [SupplierCategoryGetApiModel]?) {
        self.id = id
        self.companyName = companyName
        self.categories = categories
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "Id")
        try container.encodeIfPresent(companyName, forKey: "CompanyName")
        try container.encodeIfPresent(categories, forKey: "Categories")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(Int.self, forKey: "Id")
        companyName = try container.decodeIfPresent(String.self, forKey: "CompanyName")
        categories = try container.decodeIfPresent([SupplierCategoryGetApiModel].self, forKey: "Categories")
    }
}

