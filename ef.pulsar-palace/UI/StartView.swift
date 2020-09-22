//
//  StartView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/20/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI


struct StartView: View {
    
    @ObservedObject  var authtenticationHelper = AuthenticationHelper()
    
    var body: some View {
        NavigationView{
            Color.yellow
                .overlay(
                    Group{
                        if authtenticationHelper.isLoggedIn {
                            Group{
                                SplashUIView()
                                NavigationLink(destination: MainView()){
                                    Text("Continue")
                                }
                            }
                        }else{
                            Group{
                                SplashUIView()
                                NavigationLink(destination: SignInView()){
                                    Text("Sign In")
                                }
                            }
                        }
                    }
                )
                .edgesIgnoringSafeArea(.vertical)
        }.onAppear( perform: {
            authtenticationHelper.refreshAutenticationInfo()
        })
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
