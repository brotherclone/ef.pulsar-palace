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
    @Published var characterInitialized: Bool = false
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
        print("updating character")
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
        ZStack{
            Color.yellow
                .ignoresSafeArea()
        
                    VStack{
                        //NavigationLink(destination: MainView(), isActive: $characterCreationHelper.createdCharacter){}
                        
                        
                        SettingsButtonUIView()
                        
                        Text("Create a Character").pulsarFont(style: .h3).foregroundColor(.black)
                        
                        if characterCreationHelper.characterInitialized{
                            Group{

                                CharacterPortraitUIView(descriptor: characterCreationHelper.currentDescriptor!, role: characterCreationHelper.currentRole!, setting: characterCreationHelper.currentSetting!, height: 242, width:375)
             
                        
                        CharacterAtributesUIView(descriptor: characterCreationHelper.currentDescriptor!, role: characterCreationHelper.currentRole!, setting: characterCreationHelper.currentSetting!, background: characterCreationHelper.currentBackground!)
                        
                        Button(action:{
                            let reRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
                            characterCreationHelper.currentDescriptor = reRoll.descriptor
                            characterCreationHelper.currentRole = reRoll.role
                            characterCreationHelper.currentSetting = reRoll.setting
                            characterCreationHelper.currentBackground = reRoll.background
                        }){
                            Text("Re-Roll All").pulsarFont(style: .primaryButton).foregroundColor(Color.pink)
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
                            Text("Looks Good!").pulsarFont(style: .primaryButton).foregroundColor(Color.pink)
                        }
                        
                    }
                }
            }
        
        }.onAppear( perform: {
            print("performing on appear")
            characterCreationHelper.defaultAttributesContainer = AttributesContainer(settings: self.settings, backgrounds: self.backgrounds, descriptors: self.descriptors, roles: self.roles)
            
            authenticationHelper.refreshAutenticationInfo()
            
            //MARK: Refactor so that a blank character is rendered and the user id is added durring post
            
            
            if let currentUser: User = authenticationHelper.currentUser{
                print("current User")
                print(currentUser)
                if currentUser.id! > 0 {
                    let userId = currentUser.id
                    characterCreationHelper.currentCharacter = createBlankCharacter(userId: userId!)
                    let initRoll: AttributeContainer = rollAttributes(attributes: characterCreationHelper.defaultAttributesContainer!)
                    characterCreationHelper.currentDescriptor = initRoll.descriptor
                    characterCreationHelper.currentRole = initRoll.role
                    characterCreationHelper.currentSetting = initRoll.setting
                    characterCreationHelper.currentBackground = initRoll.background
                    characterCreationHelper.characterInitialized = true
                }else{
                    // MARK: Replace with error
                    print("rut roh")
                }
            }
            
        })
    }
}
