//
//  StartView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/20/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct StartView: View {
    
    let test = Scanner()
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Pulsar Palace")
                NavigationLink(destination: IntroView()){
                    Text("Get Started")
                }
                NavigationLink(destination: ScannerView()){
                    Text("scan")
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
