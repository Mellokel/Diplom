//
// TerminalGetApiModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class TerminalGetApiModel: Codable {

    public var id: Int?
    public var userName: String?


    
    public init(id: Int?, userName: String?) {
        self.id = id
        self.userName = userName
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "Id")
        try container.encodeIfPresent(userName, forKey: "UserName")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(Int.self, forKey: "Id")
        userName = try container.decodeIfPresent(String.self, forKey: "UserName")
    }
}

