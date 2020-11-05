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
                    VStack{
                        SplashUIView()
                        Spacer()
                        if authtenticationHelper.isLoggedIn {
                            Group{
                                NavigationLink(destination: MainView()){
                                    Text("Continue").pulsarFont(style: .primaryButton).foregroundColor(Color.pink)
                                }
                            }
                        }else{
                            Group{
                                NavigationLink(destination: SignInSignUpContainerUIView()){
                                    Text("Begin").pulsarFont(style: .primaryButton).foregroundColor(Color.pink)
                                }
                            }
                        }
                        Spacer()
                        Text("Code Owl Productions, 2020").pulsarFont(style: .lessEmphasis)
                    }
                )
                .edgesIgnoringSafeArea(.vertical)
        }.navigationViewStyle(StackNavigationViewStyle())
        .frame(alignment:.topLeading)
        .onAppear( perform: {
            authtenticationHelper.refreshAutenticationInfo()
        })
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
