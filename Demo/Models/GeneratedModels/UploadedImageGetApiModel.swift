//
// UploadedImageGetApiModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class UploadedImageGetApiModel: Codable {

    public var id: UUID?
    public var originalName: String?
    public var configuration: String?
    public var configurationVersion: Int?
    public var variations: [UploadedImageVariationGetApiModel]?


    
    public init(id: UUID?, originalName: String?, configuration: String?, configurationVersion: Int?, variations: [UploadedImageVariationGetApiModel]?) {
        self.id = id
        self.originalName = originalName
        self.configuration = configuration
        self.configurationVersion = configurationVersion
        self.variations = variations
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "Id")
        try container.encodeIfPresent(originalName, forKey: "OriginalName")
        try container.encodeIfPresent(configuration, forKey: "Configuration")
        try container.encodeIfPresent(configurationVersion, forKey: "ConfigurationVersion")
        try container.encodeIfPresent(variations, forKey: "Variations")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(UUID.self, forKey: "Id")
        originalName = try container.decodeIfPresent(String.self, forKey: "OriginalName")
        configuration = try container.decodeIfPresent(String.self, forKey: "Configuration")
        configurationVersion = try container.decodeIfPresent(Int.self, forKey: "ConfigurationVersion")
        variations = try container.decodeIfPresent([UploadedImageVariationGetApiModel].self, forKey: "Variations")
    }
}

