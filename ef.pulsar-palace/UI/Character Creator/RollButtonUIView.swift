//
//  RollButtonUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/11/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct RollButtonUIView: View {
    
    var text: String = ""
    
    var body: some View {
        HStack{
            Image("roll")
                .resizable()
                .frame(width: 40, height: 45, alignment: .leading)
            Text(self.text).pulsarFont(style: .moreEmphasis).foregroundColor(Color.black)
        }
    }
}
