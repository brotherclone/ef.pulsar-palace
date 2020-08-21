//
//  EntryView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct EntryView: View {
    var body: some View {
   
            VStack{
                Text("Add an Entry")
                NavigationLink(destination: MainView()){
                        Text("Cool")
                    }
                NavigationLink(destination: DeathView()){
                        Text("Dead")
                    }
            }
        }
    
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
