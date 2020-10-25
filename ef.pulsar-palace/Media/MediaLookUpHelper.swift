//
//  MediaLookUpHelper.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 10/1/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

struct MediaLookUpHelper {
    
    var songDictionary: [Int: (String, String)] = [
        1: ("01 Entrance","m4a"),
        2: ("02 Vestibule", "m4a"),
        3: ("03 Foyer", "m4a"),
        4: ("04 Drawing Room", "m4a"),
        5: ("05 Guest Quarters", "m4a"),
        6: ("06 Great Chamber", "m4a"),
        7: ("07 Study", "m4a"),
        8: ("08 Nursery", "m4a"),
        9: ("09 Cloak Room", "m4a"),
        10: ("10 Back Garden", "m4a")
    ]
    
    func URLFromSong(song: Song) -> URL! {
        let songId: Int = song.id
        if songId > 0{
            return self.URLFromId(id: songId)
        }else{
            return nil
        }
    }
    
    func URLFromId(id:Int)-> URL! {
        var url: URL! = nil
        if let lookup: (String, String) = self.songDictionary[id] {
            url = URL.init(fileURLWithPath: Bundle.main.path(forResource: lookup.0, ofType: lookup.1)!)
        }
        return url
    }
}
