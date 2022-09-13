//
//  File.swift
//  GitUsers
//
//  Created by Aklesh on 12/09/22.
//

import Foundation

struct UserResponse:Codable {
    var items:[User]?
}

struct User:Codable {
    
    var name:String!
    var userID:Int!
    var imageUrl:String!
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatar_url
    }
    
    public func encode(to encoder: Encoder) throws {}
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey:.login )
        userID = try values.decode(Int.self, forKey: .id)
        imageUrl = try values.decode(String.self, forKey: .avatar_url)
    }
    
}



