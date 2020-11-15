//
//  SettingsButtonUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/10/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct SettingsButtonUIView: View {
    
    @State private var isPresented = false
    
    var body: some View {
        ZStack{
            HStack{
                HStack{
                    Spacer()
                    Button(action: {
                        self.isPresented.toggle()
                    }){
                        Image("menu").resizable().frame(width: 32, height: 24, alignment: .topTrailing)
                    }
                    .fullScreenCover(isPresented: $isPresented, content: SettingsUIView.init)
                    
                }.padding(SpacingManager.oddOne.space)
            }
        }.zIndex(1)
    }
}

struct SettingsButtonUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButtonUIView()
    }
}
