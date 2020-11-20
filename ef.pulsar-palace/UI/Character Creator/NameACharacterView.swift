//
//  NameACharacterView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/13/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI
import Moya


class NameACharacterHelper: ObservableObject {
    @Published var namedCharacter: Bool = false
}

struct NameACharacterView: View {
    
    @ObservedObject var nameACharacterHelper = NameACharacterHelper()
    
    @State var character: Character
    
    @State private var nameInput: String = ""
    
    
    func updateACharacter(character:Character, updateACharacterCompletionHandler: @escaping (Response?, Error?) -> Void) {
        let networkManager = NetworkManager.provider
        networkManager.request(.updateCharacter(character: character)){ result in
            switch result{
            case let .success(moyaResponse):
                return updateACharacterCompletionHandler(moyaResponse, nil)
            case let .failure(error):
                return updateACharacterCompletionHandler(nil, error)
            }
        }
    }
    
    func finalizeCharacter(name: String){
        print("current character id \(String(describing: character.id))")
        var postCharacter = character
        postCharacter.name = name
        self.updateACharacter(character: postCharacter, updateACharacterCompletionHandler: { response, error in
            if error != nil{
                print(error as Any)
                let connectionError: Error = PulsarError.connectionError
                print(connectionError)
            }else{
                nameACharacterHelper.namedCharacter = true
            }
        })
    }
    
    var body: some View {
        ZStack{
            Color.yellow
                .ignoresSafeArea()
            GeometryReader { geo in
                VStack{
                    SettingsButtonUIView()
                    Text("Name Your Character").pulsarFont(style: .h1).foregroundColor(Color.black)
                    CharacterPortraitUIView(descriptor: character.characterDescriptor!, role: character.characterRole!, setting: character.characterSetting!, height: 200, width:  geo.size.width)
                    Text("Instructions").pulsarFont(style: .lessEmphasis).foregroundColor(Color.black)
                    TextField("Name", text: $nameInput).textFieldStyle(PulsarTextFieldStyle())
                    Button(action:{
                        self.finalizeCharacter(name: self.nameInput)
                    }){
                        Text("Create Character").pulsarFont(style: .primaryButton).foregroundColor(Color.pink)
                    }
                }
            }
        }
    }
}

