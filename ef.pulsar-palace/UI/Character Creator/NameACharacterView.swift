//
//  NameACharacterView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/13/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct NameACharacterView: View {
    
    @State var character: Character? = nil
    
    var body: some View {
        ZStack{
            VStack{
                SettingsButtonUIView()
                Text("Name Your Character")
                // Portrait
                Text("Instructions")
                //Input - Name
                //Inpu - Bio
                // Button Create (updates the record with name and bio
            }
        }
    }
}

