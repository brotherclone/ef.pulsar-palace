//
//  CharacterAtributesUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/11/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct CharacterAtributesUIView: View {
    
    var descriptor: CharacterDescriptor
    var role: CharacterRole
    var setting: CharacterSetting
    var background: CharacterBackground
    
    
    var body: some View {
        Text("I am a").pulsarFont(style: .lessEmphasis).foregroundColor(Color.black)
        
     

                Button(action: {
//                    let descriptorRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
//                    characterCreationHelper.currentDescriptor = descriptorRoll.descriptor
                }){
                    RollButtonUIView(text: descriptor.descriptor)
                }

        

        
        

                Button(action: {
//                    let descriptorRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
//                    characterCreationHelper.currentDescriptor = descriptorRoll.descriptor
                }){
                    RollButtonUIView(text: role.character_role)
                }

        
        
        Text("from").pulsarFont(style: .lessEmphasis).foregroundColor(Color.black)
        

                Button(action: {
//                    let descriptorRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
//                    characterCreationHelper.currentDescriptor = descriptorRoll.descriptor
                }){
                    RollButtonUIView(text: "\(setting.time),\(setting.place)")
                }

        
        Text("who").pulsarFont(style: .lessEmphasis).foregroundColor(Color.black)


                Button(action: {
//                    let descriptorRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
//                    characterCreationHelper.currentDescriptor = descriptorRoll.descriptor
                }){
                    RollButtonUIView(text:background.background)
                }

    
    }
}

