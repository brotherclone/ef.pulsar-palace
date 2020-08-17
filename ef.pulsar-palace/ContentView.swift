//
//  ContentView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/17/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Pulsar Palace")
            Button(
                action: {
                    // do something
                },
                label: { Text("Get Started") }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
