//
//  Users.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/28/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

public struct User {
    var id: Int
    var first_name: String
    var last_name: String
    var username: String
    var email: String
    var password: String

}

extension User: Decodable {
    
    enum UserKeys: String, CodingKey{
        case id
        case first_name
        case last_name
        case username
        case email
        case password
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        _ = try container.decode(User.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)
        _ = try container.decode(User.self, forKey: .first_name)
        first_name = try container.decode(String.self, forKey: .first_name)
        _ = try container.decode(User.self, forKey: .last_name)
        last_name = try container.decode(String.self, forKey: .last_name)
        _ = try container.decode(User.self, forKey: .username)
        username = try container.decode(String.self, forKey: .username)
        _ = try container.decode(User.self, forKey: .email)
        email = try container.decode(String.self, forKey: .email)
        _ = try container.decode(User.self, forKey: .password)
        password = try container.decode(String.self, forKey: .password)
        _ = try container.decode(User.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)
    }
}
