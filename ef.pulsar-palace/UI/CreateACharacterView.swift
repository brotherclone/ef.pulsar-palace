//
//  CreateACharacterView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI
import Moya
import SwiftyJSON

var settings: [CharacterSetting] = []
var backgrounds: [CharacterBackground] = []
var descriptors: [CharacterDescriptor] = []
var roles: [CharacterRole] = []


class CharacterValidator: ObservableObject{
    @Published var character: Character? = nil
}


func requestCharacterData(requestCharacterDataCompletionHandler: @escaping (Response?, Error?) -> Void) {
    let networkProvider = NetworkManager.provider
    networkProvider.request(.getPlayerCharacterData, completion: { result in
        switch result {
        case let .success(moyaResponse):
            requestCharacterDataCompletionHandler(moyaResponse, nil)
        case let .failure(error):
            requestCharacterDataCompletionHandler(nil, error)
        }
    })
}

func postNewCharacter(character: CharacterPost, postNewCharacterCompletionHandler: @escaping (Response?, Error?) -> Void){
    let networkProvider = NetworkManager.provider
    networkProvider.request(.newCharacter(character: character), completion: { result in
        switch result{
        case let .success(moyaResponse):
            postNewCharacterCompletionHandler(moyaResponse, nil)
        case let .failure(error):
            postNewCharacterCompletionHandler(nil, error)
        }
    })
}


func parsePlayerCharacterData(json: JSON){
    
    let characterSettings: Array<JSON> = json[0]["character_settings"].arrayValue
    let characterBackgrounds: Array<JSON> = json[0]["character_backgrounds"].arrayValue
    let characterDescriptors: Array<JSON> = json[0]["character_descriptors"].arrayValue
    let characterRoles: Array<JSON> = json[0]["character_roles"].arrayValue
    
    for item in characterSettings{
        guard let place: String = item["place"].string,
            let time: String = item["time"].string,
            let id: Int = item["id"].int
            else {
                continue
                
        }
        let setting = CharacterSetting(id: id, place: place, time: time)
        settings.append(setting)
    }
    for item in characterBackgrounds {
        guard let bg: String = item["background"].string,
            let id: Int = item["id"].int
            else{
                continue
        }
        let background = CharacterBackground(id: id, background: bg)
        backgrounds.append(background)
    }
    for item in characterDescriptors {
        guard let des: String = item["descriptor"].string,
            let id: Int = item["id"].int
            else {
                continue
        }
        let descriptor = CharacterDescriptor(id: id, descriptor: des)
        descriptors.append(descriptor)
    }
    for item in characterRoles {
        guard let r: String = item["character_role"].string,
            let id: Int = item["id"].int
            else {
                continue
        }
        let role = CharacterRole(id:id, character_role: r)
        roles.append(role)
    }
}

func roll(name: String?) -> Character? {
    var characterName: String = "Stranger"
    let user: User = User(id: 1, first_name: "String", last_name: "String", username: "String", email: "String", password: "String")
    let log: Log = Log(id:1, title: "")
    guard let background: CharacterBackground = backgrounds.randomElement(),
        let setting: CharacterSetting = settings.randomElement(),
        let role: CharacterRole = roles.randomElement(),
        let descriptor: CharacterDescriptor = descriptors.randomElement()
        else{
            print("error")
            return nil
    }
    
    if name != nil{
        characterName = name!
    }
    let character: Character = Character(user: user,
                                         name: characterName,
                                         additionalBio: "Bio",
                                         characterBackground:background,
                                         characterSetting: setting,
                                         characterRole: role,
                                         characterDescriptor: descriptor,
                                         currentHealth: 4,
                                         maxHealth: 4,
                                         log: log,
                                         archived: false)
    return character
}


func sendCharacter(character: Character?){
    
    let post = CharacterPost(character: character!)
    
    postNewCharacter(character: post, postNewCharacterCompletionHandler: { response, error in
        if error != nil{
            print(error as Any)
        } else {
            print(response as Any)
            do {
                let data = response!.data
                let json = try JSON(data: data)
                print(json)
                
                let anIDExample: [CharacterDescriptor] = descriptors.filter { $0.id == 1}
                let dExample: CharacterDescriptor = anIDExample[0]
                print(dExample)
                
            }catch{
                print("conversion error")
            }
        }
    })
}



struct CreateACharacterView: View {
    
    @ObservedObject var availableCharacter = CharacterValidator()
    
    @State private var characterNameInput: String = ""
    
    var body: some View {
        Group{
            if self.availableCharacter.character != nil{
                Group{
                    Text("Create a Character")
                    TextField("Character Name", text: $characterNameInput)
                    CharacterUIView(character: availableCharacter.character!)
                    Button(action:{
                        self.availableCharacter.character = roll(name: self.characterNameInput)
                    }){
                        Text("Re-Roll")
                    }
                    Button(action: {
                        self.availableCharacter.character!.name = self.characterNameInput
                        sendCharacter(character: self.availableCharacter.character)
                    }){
                        Text("Use this character")
                    }
                }
            }else{
                VStack{
                    Text("Create a Character")
                    Button(action:{
                        self.availableCharacter.character = roll(name: nil)
                    }){
                        Text("Roll")
                    }
                }.onAppear {
                    requestCharacterData( requestCharacterDataCompletionHandler: { response, error in
                        if error != nil{
                            print(error as Any)
                        } else {
                            print(response as Any)
                            do {
                                let data = response!.data
                                let json = try JSON(data: data)
                                parsePlayerCharacterData(json: json)
                            } catch  {
                                print("error")
                            }
                        }
                    })
                }
            }
        }
    }
}

struct CreateACharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CreateACharacterView()
    }
}
