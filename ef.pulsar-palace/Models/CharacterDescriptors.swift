//
//  CharacterDescriptors.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/28/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

public struct CharacterDescriptor {
    var id: Int
    var descriptor: String
}

extension CharacterDescriptor: Encodable, Decodable {
    
    enum CharacterDescriptorKeys: String, CodingKey{
        case id
        case descriptor
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterDescriptorKeys.self)
        _ = try container.decode(CharacterDescriptor.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)
        _ = try container.decode(CharacterDescriptor.self, forKey: .descriptor)
        descriptor = try container.decode(String.self, forKey: .descriptor)
        
    }
}
