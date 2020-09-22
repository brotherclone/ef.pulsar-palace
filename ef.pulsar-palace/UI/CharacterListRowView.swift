//
//  CharacterListRowView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/22/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct CharacterListRowView: View {
    
    var character: Character
    
    var body: some View {
        Text(character.name)
    }
}

//struct CharacterListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterListRowView()
//    }
//}

// MARK: Show preview with mocks
