//
//  SignInView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
            VStack{
                Text("Sign In")
                NavigationLink(destination: HaveCardView()){
                    Text("Sign Me In")
                }
            }
        }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
