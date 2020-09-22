//
//  CharacterListView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/22/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct CharacterListView: View {
    
    var characters: [Character]?

    
    var body: some View {
        NavigationView{
            List(characters!, id: \.id) { character in
                CharacterListRowView(character: character)
            }
        }
    }
}

//struct CharacterListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterListView()
//    }
//}

// MARK: Show preview with mocks
