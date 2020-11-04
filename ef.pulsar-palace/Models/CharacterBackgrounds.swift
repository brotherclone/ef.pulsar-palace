//
//  CharacterBackgrounds.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/26/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

public struct CharacterBackground {
    var id: Int
    var background: String
}

extension CharacterBackground: Encodable, Decodable {
    
    enum CharacterBackgroundKeys: String, CodingKey{
        case id
        case background
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterBackgroundKeys.self)
        _ = try container.decode(CharacterBackground.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)
        _ = try container.decode(CharacterBackground.self, forKey: .background)
        background = try container.decode(String.self, forKey: .background)
    }
}
