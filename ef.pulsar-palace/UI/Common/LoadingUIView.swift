//
//  LoadingUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/6/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct LoadingUIView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            // MARK: To Style
            Button("Dismiss") {
                   presentationMode.wrappedValue.dismiss()
            }.offset(x:0, y:-100)
            Group{
                LoadingCirclesUI(leftToRight: false, speed: 1.0)
                LoadingCirclesUI(leftToRight: false, speed: 1.01)
                LoadingCirclesUI(leftToRight: false, speed: 1.02)
                LoadingCirclesUI(leftToRight: false, speed: 1.03)
                LoadingCirclesUI(leftToRight: false, speed: 1.04)
                LoadingCirclesUI(leftToRight: false, speed: 1.05)
            }.offset(x: -20, y:0)
            Group{
                LoadingCirclesUI(leftToRight: true, speed: 1.0)
                LoadingCirclesUI(leftToRight: true, speed: 1.01)
                LoadingCirclesUI(leftToRight: true, speed: 1.02)
                LoadingCirclesUI(leftToRight: true, speed: 1.03)
                LoadingCirclesUI(leftToRight: true, speed: 1.04)
                LoadingCirclesUI(leftToRight: true, speed: 1.05)
            }.offset(x:20, y:0)
            Text("LOADING").pulsarFont(style:.h2).foregroundColor(Color.pink)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoadingUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingUIView()
    }
}
