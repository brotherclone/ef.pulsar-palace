//
//  EntryListView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/22/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct EntryListView: View {
    
    var character: Character
    var entries: [Entry]?
    
    var body: some View {
        NavigationView{
            List(entries!, id: \.id) { entry in
                EntryListRowView(entry: entry)
            }
        }
    }
}

