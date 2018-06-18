//
// CommodityCategoryGetSingleApiModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class CommodityCategoryGetSingleApiModel: Codable {

    public var id: Int?
    public var parentId: Int?
    public var name: String?
    public var nameSingular: String?
    public var serviceFee: ServiceFee?
    public var concurrencyToken: UUID?
    public var fields: [CommodityCategoryFieldGetApiModel]?


    
    public init(id: Int?, parentId: Int?, name: String?, nameSingular: String?, serviceFee: ServiceFee?, concurrencyToken: UUID?, fields: [CommodityCategoryFieldGetApiModel]?) {
        self.id = id
        self.parentId = parentId
        self.name = name
        self.nameSingular = nameSingular
        self.serviceFee = serviceFee
        self.concurrencyToken = concurrencyToken
        self.fields = fields
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "Id")
        try container.encodeIfPresent(parentId, forKey: "ParentId")
        try container.encodeIfPresent(name, forKey: "Name")
        try container.encodeIfPresent(nameSingular, forKey: "NameSingular")
        try container.encodeIfPresent(serviceFee, forKey: "ServiceFee")
        try container.encodeIfPresent(concurrencyToken, forKey: "ConcurrencyToken")
        try container.encodeIfPresent(fields, forKey: "Fields")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(Int.self, forKey: "Id")
        parentId = try container.decodeIfPresent(Int.self, forKey: "ParentId")
        name = try container.decodeIfPresent(String.self, forKey: "Name")
        nameSingular = try container.decodeIfPresent(String.self, forKey: "NameSingular")
        serviceFee = try container.decodeIfPresent(ServiceFee.self, forKey: "ServiceFee")
        concurrencyToken = try container.decodeIfPresent(UUID.self, forKey: "ConcurrencyToken")
        fields = try container.decodeIfPresent([CommodityCategoryFieldGetApiModel].self, forKey: "Fields")
    }
}
