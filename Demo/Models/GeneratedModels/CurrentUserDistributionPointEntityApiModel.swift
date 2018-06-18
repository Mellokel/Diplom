//
// CurrentUserDistributionPointEntityApiModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class CurrentUserDistributionPointEntityApiModel: Codable {

    public var id: Int?
    public var city: String?
    public var streetName: String?
    public var streetNumber: String?


    
    public init(id: Int?, city: String?, streetName: String?, streetNumber: String?) {
        self.id = id
        self.city = city
        self.streetName = streetName
        self.streetNumber = streetNumber
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "Id")
        try container.encodeIfPresent(city, forKey: "City")
        try container.encodeIfPresent(streetName, forKey: "StreetName")
        try container.encodeIfPresent(streetNumber, forKey: "StreetNumber")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(Int.self, forKey: "Id")
        city = try container.decodeIfPresent(String.self, forKey: "City")
        streetName = try container.decodeIfPresent(String.self, forKey: "StreetName")
        streetNumber = try container.decodeIfPresent(String.self, forKey: "StreetNumber")
    }
}
