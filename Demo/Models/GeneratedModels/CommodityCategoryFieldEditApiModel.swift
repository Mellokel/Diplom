//
// CommodityCategoryFieldEditApiModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class CommodityCategoryFieldEditApiModel: Codable {

    public var fieldId: Int?
    public var isPerVariation: Bool?
    public var isDisplayable: Bool?
    public var isSelectable: Bool?


    
    public init(fieldId: Int?, isPerVariation: Bool?, isDisplayable: Bool?, isSelectable: Bool?) {
        self.fieldId = fieldId
        self.isPerVariation = isPerVariation
        self.isDisplayable = isDisplayable
        self.isSelectable = isSelectable
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(fieldId, forKey: "FieldId")
        try container.encodeIfPresent(isPerVariation, forKey: "IsPerVariation")
        try container.encodeIfPresent(isDisplayable, forKey: "IsDisplayable")
        try container.encodeIfPresent(isSelectable, forKey: "IsSelectable")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        fieldId = try container.decodeIfPresent(Int.self, forKey: "FieldId")
        isPerVariation = try container.decodeIfPresent(Bool.self, forKey: "IsPerVariation")
        isDisplayable = try container.decodeIfPresent(Bool.self, forKey: "IsDisplayable")
        isSelectable = try container.decodeIfPresent(Bool.self, forKey: "IsSelectable")
    }
}
