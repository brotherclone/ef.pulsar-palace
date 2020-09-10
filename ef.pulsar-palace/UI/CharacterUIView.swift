//
//  CharacterUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/8/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI



struct CharacterUIView: View {
    
    var character: Character    
    
    var body: some View {
        VStack{
            Text(character.characterBackground.background)
            Text(character.characterRole.character_role)
            Text(character.characterSetting.place)
            Text(character.characterSetting.time)
            Text(character.characterDescriptor.descriptor)
        }
    }
}



// MARK: Add Preview from Mocks

//struct CharacterUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterUIView()
//    }
//}
