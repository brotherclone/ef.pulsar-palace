//
//  EntryListRowView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/22/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct EntryListRowView: View {
    
    var entry: Entry
    
    var body: some View {
        Group{
            // MARK: This should actually be the prompt title
            Text(entry.entry_text)
        }
    }
}

//struct EntryListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryListRowView()
//    }
//}
// MARK: Show preview with mocks
