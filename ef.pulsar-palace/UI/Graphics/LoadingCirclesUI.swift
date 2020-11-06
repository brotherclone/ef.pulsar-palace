//
//  LoadingCirclesUI.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/6/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI



struct LoadingCirclesUI: View {
    
    @State var isAnimating = false
    @State var leftToRight = true
    @State var speed = 0.5
    @State var distance = 100
    
    
    
    var body: some View {
        Circle()
            .stroke(self.isAnimating ? Color.white.opacity(0.01) : Color.white.opacity(1.0), lineWidth: 5)
            .offset(x:CGFloat(self.isAnimating ? 0 : self.leftToRight ? (self.distance * -1) : self.distance), y: 0)
            .frame(width: 100, height: 100)
            .animation(Animation.linear(duration: self.speed).repeatForever(autoreverses:false))
            .onAppear {
                self.isAnimating = true
            }
    }
}

struct LoadingCirclesUI_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCirclesUI()
    }
}
