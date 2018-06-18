//
// CommodityCategoryUpdateApiModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class CommodityCategoryUpdateApiModel: Codable {

    public var name: String?
    public var nameSingular: String?
    public var serviceFeeId: Int?
    public var concurrencyToken: UUID?
    public var fields: [CommodityCategoryFieldEditApiModel]?


    
    public init(name: String?, nameSingular: String?, serviceFeeId: Int?, concurrencyToken: UUID?, fields: [CommodityCategoryFieldEditApiModel]?) {
        self.name = name
        self.nameSingular = nameSingular
        self.serviceFeeId = serviceFeeId
        self.concurrencyToken = concurrencyToken
        self.fields = fields
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(name, forKey: "Name")
        try container.encodeIfPresent(nameSingular, forKey: "NameSingular")
        try container.encodeIfPresent(serviceFeeId, forKey: "ServiceFeeId")
        try container.encodeIfPresent(concurrencyToken, forKey: "ConcurrencyToken")
        try container.encodeIfPresent(fields, forKey: "Fields")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decodeIfPresent(String.self, forKey: "Name")
        nameSingular = try container.decodeIfPresent(String.self, forKey: "NameSingular")
        serviceFeeId = try container.decodeIfPresent(Int.self, forKey: "ServiceFeeId")
        concurrencyToken = try container.decodeIfPresent(UUID.self, forKey: "ConcurrencyToken")
        fields = try container.decodeIfPresent([CommodityCategoryFieldEditApiModel].self, forKey: "Fields")
    }
}
