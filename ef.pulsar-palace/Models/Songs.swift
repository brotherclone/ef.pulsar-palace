//
//  Songs.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/28/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

public struct Song {
    var id: Int
    var title: String
    var trt: String
    var song_order: Int
}

extension Song: Decodable {
    
    enum SongKeys: String, CodingKey{
        case id
        case title
        case trt
        case song_order
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        _ = try container.decode(Song.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)
        _ = try container.decode(Song.self, forKey: .title)
        title = try container.decode(String.self, forKey: .title)
        _ = try container.decode(Song.self, forKey: .trt)
        trt = try container.decode(String.self, forKey: .trt)
        _ = try container.decode(Song.self, forKey: .song_order)
        song_order = try container.decode(Int.self, forKey: .song_order)
        
    }
}
