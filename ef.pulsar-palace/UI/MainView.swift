//
//  MainView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//


import SwiftUI
import Moya
import SwiftyJSON

class MainViewStatusHelper: ObservableObject {
    
    @Published var activeCharacter: Character? = nil
    @Published var playerDataIsReady: Bool  = false
    @Published var nonActiveCharacters: [Character] = []
    
}


struct MainView: View {
    
    @ObservedObject var mainStatusHelper = MainViewStatusHelper()
    @ObservedObject var authtenticationHelper = AuthenticationHelper()
    
    func getUsersCharacters(userId:Int, getUsersCharactersCompletionHanlder: @escaping (Response?, Error?) -> Void){
        if UserDefaults.contains(UserDefaults.Keys.token){
            let defaults = UserDefaults.standard
            let token = defaults.string(forKey:UserDefaults.Keys.token)
            let authPlugin = AccessTokenPlugin { _ in token! }
            let authenticatedProvider = MoyaProvider<APITargets>(plugins: [authPlugin])
            authenticatedProvider.request(.getUsersCharacters(userId: 1)){ result in
                switch result{
                case let .success(moyaResponse):
                    getUsersCharactersCompletionHanlder(moyaResponse, nil)
                case let .failure(error):
                    getUsersCharactersCompletionHanlder(nil, error)
                }
            }
        }
    }
    
    func getPlayerCharacterData(getPlayerCharacterDataCompletionHandler: @escaping (Response?, Error?) -> Void){
        let networkProvider = NetworkManager.provider
        networkProvider.request(.getPlayerCharacterInfo){ result in
            switch result{
            case let .success(moyaResponse):
                getPlayerCharacterDataCompletionHandler(moyaResponse, nil)
            case let .failure(error):
                getPlayerCharacterDataCompletionHandler(nil, error)
            }
        }
    }
    
    
    func initializeCharacters(backgrounds: [CharacterBackground], settings: [CharacterSetting], descriptors: [CharacterDescriptor], roles: [CharacterRole]){
        //MARK: Takes the info from the Player Character data, now in environment data, and comebines combines it with individual characters to create character data.
        
        getPlayerCharacterData(getPlayerCharacterDataCompletionHandler: { response, error in
            if error != nil{
                print(error as Any)
            }else{
                var nonActivePlayerCharacters: [Character] = []
                do{
                    let json = try JSON(data: response!.data)
                    if let characters: [JSON] = json["characters"].array{
                        for character in characters{
                            if var aCharacter: Character = character.object as? Character{
                                let backgroundId: Int? = character["character_background_id"].intValue as Int?
                                if backgroundId != nil{
                                    let backgroundSelection = backgrounds.filter{
                                        $0.id == backgroundId
                                    }
                                    aCharacter.characterBackground = backgroundSelection[0]
                                }
                                let descriptorId: Int? = character["character_descriptor_id"].intValue as Int?
                                if descriptorId != nil{
                                    let descriptorSelection = descriptors.filter{
                                        $0.id == descriptorId
                                    }
                                    aCharacter.characterDescriptor = descriptorSelection[0]
                                }
                                let roleId: Int? = character["character_role_id"].intValue as Int?
                                if roleId != nil{
                                    let roleSelection = roles.filter{
                                        $0.id == roleId
                                    }
                                    aCharacter.characterRole = roleSelection[0]
                                }
                                let settingId: Int? = character["character_setting_id"].intValue as Int?
                                if settingId != nil{
                                    let settingSelection = settings.filter{
                                        $0.id == settingId
                                    }
                                    aCharacter.characterSetting = settingSelection[0]
                                }
                                if aCharacter.archived == true {
                                    nonActivePlayerCharacters.append(aCharacter)
                                }else{
                                    mainStatusHelper.activeCharacter = aCharacter
                                }
                            }
                        }
                        mainStatusHelper.nonActiveCharacters = nonActivePlayerCharacters
                    }
                }catch{
                    print("Error Parsing JSON")
                }
            }
        })
    }
    
    func parsePlayerCharacterData(data: Data!){
        //MARK: Parse player character data from server and then populate an environment variable for cross view reference
        if data == nil{
            self.mainStatusHelper.playerDataIsReady = false
        }else{
            do {
                let json = try JSON(data:data)
                var characterRoles: [CharacterRole] = []
                if let roles: [Any] = json["character_roles"].array {
                    for role in roles {
                        let aRole: CharacterRole = role as! CharacterRole
                        characterRoles.append(aRole)
                    }
                }
                var characterSettings: [CharacterSetting] = []
                if let settings: [Any] = json["character_settings"].array {
                    for setting in settings{
                        let aSetting: CharacterSetting = setting as! CharacterSetting
                        characterSettings.append(aSetting)
                    }
                }
                var characterDescriptors: [CharacterDescriptor] = []
                if let descriptors: [Any] = json["character_descriptors"].array {
                    for descriptor in descriptors{
                        let aDescriptor: CharacterDescriptor = descriptor as! CharacterDescriptor
                        characterDescriptors.append(aDescriptor)
                    }
                }
                var characterBackgrounds: [CharacterBackground] = []
                if let backgrounds: [Any] = json["character_backgrounds"].array{
                    for background in backgrounds{
                        let aBackground: CharacterBackground = background as! CharacterBackground
                        characterBackgrounds.append(aBackground)
                    }
                }
                initializeCharacters(backgrounds: characterBackgrounds, settings:characterSettings, descriptors: characterDescriptors, roles: characterRoles)
                
                self.mainStatusHelper.playerDataIsReady = true
                
            }catch{
                print("JSON parsing error: Player Character Data")
                self.mainStatusHelper.playerDataIsReady = false
            }
        }
    }
    
    
    var body: some View {
        Group{
            // MARK: If there's an active character display that view...
            if mainStatusHelper.playerDataIsReady == false{
                Group{
                    // MARK: Replace with animation
                    Text("Loading")
                }
            }
            if mainStatusHelper.activeCharacter != nil {
                Group{
                    ActiveCharacterCardView(character: mainStatusHelper.activeCharacter!)
                    // MARK: And offer the user the ability to add a new entry with that character.
                    // MARK: Or, if previous entries exists, display a means to see that view.
                }
            } else {
                Group{
                    // MARK: If there's no active character, give the user a link to create one.
                    NavigationLink(destination: CreateACharacterView()){
                        Text("Create a Character")
                    }
                }
            }
            Group{
                CharacterListView(characters: mainStatusHelper.nonActiveCharacters)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear( perform: {
            authtenticationHelper.refreshAutenticationInfo()
            self.getPlayerCharacterData(getPlayerCharacterDataCompletionHandler: { response, error in
                if error != nil{
                    print(error as Any)
                }else{
                    // MARK: All Player Character Data is loaded and parsed
                    parsePlayerCharacterData(data: response!.data)
                }
            })
        })
    }
}
