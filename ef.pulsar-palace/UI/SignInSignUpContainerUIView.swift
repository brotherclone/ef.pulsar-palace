//
//  SignInSignUpContainerUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/4/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct SignInSignUpContainerUIView: View {
    @State var showMenu = false
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    SignInView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        SettingsUIView(showMenu: self.$showMenu)
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(drag)
            }
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SignInSignUpContainerUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignInSignUpContainerUIView()
    }
}
