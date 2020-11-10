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




class CharacterCreationHelper: ObservableObject {
    @Published var createdCharacter: Bool = false
    @Published var currentSetting: CharacterSetting? = nil
    @Published var currentBackground: CharacterBackground? = nil
    @Published var currentDescriptor: CharacterDescriptor? = nil
    @Published var currentRole: CharacterRole? = nil
    @Published var currentCharacter: Character? = nil
    @Published var defaultAttributesContainer: AttributesContainer? = nil
}

struct AttributeContainer {
    var setting: CharacterSetting?
    var background: CharacterBackground?
    var descriptor: CharacterDescriptor?
    var role: CharacterRole?
}

struct AttributesContainer {
    var settings: [CharacterSetting]?
    var backgrounds: [CharacterBackground]?
    var descriptors: [CharacterDescriptor]?
    var roles: [CharacterRole]?
}


struct CreateACharacterView: View {
    
    @ObservedObject var characterCreationHelper = CharacterCreationHelper()
    @ObservedObject var authenticationHelper = AuthenticationHelper()
    
    var settings: [CharacterSetting]
    var backgrounds: [CharacterBackground]
    var roles: [CharacterRole]
    var descriptors:[CharacterDescriptor]
    
    @State var inputName: String = ""
    @State var inputBio: String = ""
    
    func rollAttributes(attributes: AttributesContainer) -> AttributeContainer {
        print("rollAttributes \(attributes)")
        let settingRoll = attributes.settings?.randomElement()
        let backgroundRoll = attributes.backgrounds?.randomElement()
        let descriptorRoll = attributes.descriptors?.randomElement()
        let roleRoll = attributes.roles?.randomElement()
        // MARK: Can either pass in filtered or filter here for Logs
        let results: AttributeContainer = AttributeContainer(setting: settingRoll, background:backgroundRoll, descriptor: descriptorRoll, role: roleRoll)
        return results
    }
    
    func createBlankCharacter(userId:Int)-> Character {
        print("creating character for userId: \(userId)")
        return Character(user_id: userId,
                         name: "",
                         character_background_id: 1,
                         character_setting_id: 1,
                         character_role_id: 1,
                         character_descriptor_id: 1,
                         current_health: DefaultCharacterAttributes.current_health,
                         max_health: DefaultCharacterAttributes.max_health,
                         archived: false)
    }
    
    func updateCharacter(name: String, bio: String) -> Character{
        characterCreationHelper.currentCharacter?.name = name
        characterCreationHelper.currentCharacter?.additional_bio = bio
        characterCreationHelper.currentCharacter?.characterBackground = characterCreationHelper.currentBackground
        characterCreationHelper.currentCharacter?.characterSetting = characterCreationHelper.currentSetting
        characterCreationHelper.currentCharacter?.characterDescriptor = characterCreationHelper.currentDescriptor
        characterCreationHelper.currentCharacter?.characterRole = characterCreationHelper.currentRole
        // MARK: Clean up object relations for posting.
        return Character(user_id: characterCreationHelper.currentCharacter!.user_id,
                         name: characterCreationHelper.currentCharacter!.name,
                         additional_bio: characterCreationHelper.currentCharacter!.additional_bio,
                         character_background_id: characterCreationHelper.currentCharacter!.characterBackground!.id,
                         character_setting_id: characterCreationHelper.currentCharacter!.characterSetting!.id,
                         character_role_id: characterCreationHelper.currentCharacter!.characterRole!.id,
                         character_descriptor_id: characterCreationHelper.currentCharacter!.characterDescriptor!.id,
                         current_health: characterCreationHelper.currentCharacter!.current_health,
                         max_health: characterCreationHelper.currentCharacter!.max_health,
                         archived: characterCreationHelper.currentCharacter!.archived)
    }
    
    func postACharacter(character:Character, postACharacterCompletionHandler: @escaping (Response?, Error?) -> Void) {
        let networkManager = NetworkManager.provider
        networkManager.request(.createCharacter(character: character)){ result in
            switch result{
            case let .success(moyaResponse):
                return postACharacterCompletionHandler(moyaResponse, nil)
            case let .failure(error):
                return postACharacterCompletionHandler(nil, error)
            }
        }
    }
    
    var body: some View {
        Group{
            NavigationLink(destination: MainView(), isActive: $characterCreationHelper.createdCharacter){}
            Text("Create a Character")
            CharacterPortraitUIView()
            TextField("Character Name", text: $inputName)
            TextField("Bio", text: $inputBio)
            Group{
                if characterCreationHelper.currentDescriptor != nil{
                    Group{
                        Text("Descriptor:")
                        HStack{
                            Text(characterCreationHelper.currentDescriptor!.descriptor)
                            Button(action: {
                                let descriptorRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
                                characterCreationHelper.currentDescriptor = descriptorRoll.descriptor
                            }){
                                Text("Re-Roll")
                            }
                        }
                    }
                }
            }
            Group{
                if characterCreationHelper.currentRole != nil{
                    Group{
                        Text("Role:")
                        HStack{
                            Text(characterCreationHelper.currentRole!.character_role)
                            Button(action: {
                                let roleRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
                                characterCreationHelper.currentRole = roleRoll.role
                            }){
                                Text("Re-Roll")
                            }
                        }
                    }
                }
            }
            Group{
                if characterCreationHelper.currentSetting != nil {
                    Group{
                        Text("Setting:")
                        HStack{
                            Text("\(characterCreationHelper.currentSetting!.time),\(characterCreationHelper.currentSetting!.place)")
                            Button(action: {
                                let settingRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
                                characterCreationHelper.currentSetting = settingRoll.setting
                            }){
                                Text("Re-Roll")
                            }
                        }
                    }
                }
            }
            Group{
                if characterCreationHelper.currentBackground != nil{
                    Group{
                        Text("Background:")
                        HStack{
                            Text(characterCreationHelper.currentBackground!.background)
                            Button(action: {
                                let backgroundRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
                                characterCreationHelper.currentBackground = backgroundRoll.background
                            }){
                                Text("Re-Roll")
                            }
                        }
                    }
                }
            }
            Group{
                Button(action:{
                    let reRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
                    characterCreationHelper.currentDescriptor = reRoll.descriptor
                    characterCreationHelper.currentRole = reRoll.role
                    characterCreationHelper.currentSetting = reRoll.setting
                    characterCreationHelper.currentBackground = reRoll.background
                }){
                    Text("Re-Roll All Attributes")
                }
                Button(action:{
                    let postCharacter: Character = updateCharacter(name: self.inputName, bio: self.inputBio)
                    self.postACharacter(character: postCharacter, postACharacterCompletionHandler: { response, error in
                        if error != nil{
                            print(error as Any)
                        }else{
                            characterCreationHelper.createdCharacter = true
                        }
                    })
                }){
                    Text("Begin Exploring with this Character")
                }
            }
        }.onAppear( perform: {
            characterCreationHelper.defaultAttributesContainer = AttributesContainer(settings: self.settings, backgrounds: self.backgrounds, descriptors: self.descriptors, roles: self.roles)
            authenticationHelper.refreshAutenticationInfo()
            if let currentUser: User = authenticationHelper.currentUser{
                if currentUser.id! > 0 {
                    let userId = currentUser.id
                    characterCreationHelper.currentCharacter = createBlankCharacter(userId: userId!)
                    let initRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
                    characterCreationHelper.currentDescriptor = initRoll.descriptor
                    characterCreationHelper.currentRole = initRoll.role
                    characterCreationHelper.currentSetting = initRoll.setting
                    characterCreationHelper.currentBackground = initRoll.background
                }else{
                    print("rut roh")
                }
            }
        
        })
    }
    
}

//struct CreateACharacterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateACharacterView()
//    }
//}

// MARK: Fix with mocks
