//
//  DeathView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct DeathView: View {
    var body: some View {

            VStack{
                NavigationLink(destination: MainView()){
                        Text("Bye")
                    }
            }
        }
    
}

struct DeathView_Previews: PreviewProvider {
    static var previews: some View {
        DeathView()
    }
}
