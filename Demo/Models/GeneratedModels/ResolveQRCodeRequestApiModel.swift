//
// ResolveQRCodeRequestApiModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class ResolveQRCodeRequestApiModel: Codable {

    public var text: String?


    
    public init(text: String?) {
        self.text = text
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(text, forKey: "Text")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        text = try container.decodeIfPresent(String.self, forKey: "Text")
    }
}

