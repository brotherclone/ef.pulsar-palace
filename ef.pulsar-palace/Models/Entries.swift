//
//  Entries.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/28/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

public struct Entry {
    var id: Int
    var entry_text: String
    var prompt: Prompt
    var character: Character
}

extension Entry: Decodable {
    
    enum EntryKeys: String, CodingKey{
        case id
        case entry_text
        case prompt
        case character
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EntryKeys.self)
        _ = try container.decode(Entry.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)
        _ = try container.decode(Entry.self, forKey: .entry_text)
        entry_text = try container.decode(String.self, forKey: .entry_text)
        _ = try container.decode(Entry.self, forKey: .prompt)
        prompt = try container.decode(Prompt.self, forKey: .prompt)
        _ = try container.decode(Entry.self, forKey: .character)
        character = try container.decode(Character.self, forKey: .character)
    }
}
