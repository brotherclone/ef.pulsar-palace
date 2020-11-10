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
        Button("🍔") {
                  self.isPresented.toggle()
              }
              .fullScreenCover(isPresented: $isPresented, content: SettingsUIView.init)
        
    }
}

struct SettingsButtonUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButtonUIView()
    }
}
