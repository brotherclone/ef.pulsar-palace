//
//  SettingsRowItemUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/10/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct SettingsRowItemUIView: View {
    
    @State var buttonText:String = ""
    
    var body: some View {
        HStack{
            HStack{
                Text(self.buttonText).pulsarFont(style: .body).frame(alignment: .leading).foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right").frame(alignment: .trailing)
            }.padding(SpacingManager.edge.space)
        }.background(Color.yellow)
    }
}

struct SettingsRowItemUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowItemUIView(buttonText: "Text")
    }
}
