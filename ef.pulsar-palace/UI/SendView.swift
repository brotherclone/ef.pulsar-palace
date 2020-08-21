//
//  SendView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct SendView: View {
    var body: some View {

            VStack{
                Text("Send to Friend")
                NavigationLink(destination: MainView()){
                        Text("Well okay")
                    }
            }
        }
    
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
