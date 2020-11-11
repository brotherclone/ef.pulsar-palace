//
//  CharacterHealthUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/11/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct CharacterHealthUIView: View {
    
    var health: Int = 0
    
    var body: some View {
        Group{
            if health < 1{
                Group{
                    HStack(spacing:SpacingManager.barely.space){
                        Image("health-off")
                            .resizable()
                            .scaledToFit()
                        Image("health-off")
                            .resizable()
                            .scaledToFit()
                        Image("health-off")
                            .resizable()
                            .scaledToFit()
                    }
                }.frame(width: 100, height: 100, alignment: .center)
            }else if health == 1{
                Group{
                    HStack(spacing:SpacingManager.barely.space){
                        Image("health-on")
                            .resizable()
                            .scaledToFit()
                        Image("health-off")
                            .resizable()
                            .scaledToFit()
                        Image("health-off")
                            .resizable()
                            .scaledToFit()
                    }
                }.frame(width: 100, height: 100, alignment: .center)
            }else if health == 2{
                Group{
                    HStack(spacing:SpacingManager.barely.space){
                        Image("health-on")
                            .resizable()
                            .scaledToFit()
                        Image("health-on")
                            .resizable()
                            .scaledToFit()
                        Image("health-off")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }else if health > 2 {
                Group{
                    HStack{
                        Image("health-on")
                            .resizable()
                            .scaledToFit()
                        Image("health-on")
                            .resizable()
                            .scaledToFit()
                        Image("health-on")
                            .resizable()
                            .scaledToFit()
                    }
                }.frame(width: 100, height: 100, alignment: .center)
            }
        }
    }
}
