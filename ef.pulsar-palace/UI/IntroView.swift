//
//  IntroView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct IntroView: View {
    var body: some View {

            VStack{
                Text("Intro text")
                NavigationLink(destination: SignInView()){
                                 Text("Sign In")
                             }
                NavigationLink(destination: HaveCardView()){
                                 Text("Proceed without")
                             }
                
            }
        
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
