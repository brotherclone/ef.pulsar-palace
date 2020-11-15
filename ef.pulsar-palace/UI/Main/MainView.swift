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
    @Published var settings: [CharacterSetting] = []
    @Published var backgrounds: [CharacterBackground] = []
    @Published var roles: [CharacterRole] = []
    @Published var descriptors: [CharacterDescriptor]=[]
    
}

struct MainView: View {
    
    @ObservedObject var mainStatusHelper = MainViewStatusHelper()
    @ObservedObject var authtenticationHelper = AuthenticationHelper()
    
    @State private var isAlerting = false
    
    @State private var currentError: PulsarError? = nil
    
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
                self.currentError = PulsarError.connectionError
                self.isAlerting = true
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
                    self.currentError = PulsarError.parsingError
                    self.isAlerting = true
                }
            }
        })
    }
    
    func parsePlayerCharacterData(data: Data!){
        if data == nil{
            self.mainStatusHelper.playerDataIsReady = false
        }else{
            do {
                let json = try JSON(data:data)
                var characterRoles: [CharacterRole] = []
                if let roles: Array = json[0]["character_roles"].array {
                    for role in roles {
                        let aRole: CharacterRole = CharacterRole(id: role["id"].intValue,
                                                                 character_role:role["character_role"].stringValue, imageURL: role["image_url"].stringValue)
                        characterRoles.append(aRole)
                    }
                    mainStatusHelper.roles = characterRoles
                }else{
                    print("error parsing player character data: roles")
                }
                var characterSettings: [CharacterSetting] = []
                if let settings: Array = json[0]["character_settings"].array {
                    for setting in settings{
                        let aSetting: CharacterSetting = CharacterSetting(id: setting["id"].intValue,
                                                                           place: setting["place"].stringValue,
                                                                           time: setting["time"].stringValue, imageURL: setting["image_url"].stringValue)
                        characterSettings.append(aSetting)
                    }
                    mainStatusHelper.settings = characterSettings
                }else{
                    self.currentError = PulsarError.parsingError
                    self.isAlerting = true
                }
                var characterDescriptors: [CharacterDescriptor] = []
                if let descriptors: Array = json[0]["character_descriptors"].array {
                    for descriptor in descriptors{
                        let aDescriptor: CharacterDescriptor = CharacterDescriptor(id: descriptor["id"].intValue,
                                                                                   descriptor: descriptor["descriptor"].stringValue,
                                                                                   imageURL: descriptor["image_url"].stringValue)
                        characterDescriptors.append(aDescriptor)
                    }
                    mainStatusHelper.descriptors = characterDescriptors
                }else{
                    let error: Error = PulsarError.parsingError
                    print(error.localizedDescription)
                }
                var characterBackgrounds: [CharacterBackground] = []
                if let backgrounds: Array = json[0]["character_backgrounds"].array{
                    for background in backgrounds{
                        let aBackground: CharacterBackground = CharacterBackground(id: background["id"].intValue, background: background["background"].stringValue)
                        characterBackgrounds.append(aBackground)
                    }
                    mainStatusHelper.backgrounds = characterBackgrounds
                }else{
                    self.currentError = PulsarError.parsingError
                    self.isAlerting = true
                }
                initializeCharacters(backgrounds: characterBackgrounds, settings:characterSettings, descriptors: characterDescriptors, roles: characterRoles)
                self.mainStatusHelper.playerDataIsReady = true
            }catch{
                self.currentError = PulsarError.parsingError
                self.isAlerting = true
                self.mainStatusHelper.playerDataIsReady = false
            }
        }
    }
    
    var body: some View {
        NavigationView{
            Group{
                // MARK: If there's an active character display that view...
                Group{
                    if mainStatusHelper.playerDataIsReady == false{
                        Group{
                            LoadingUIView()
                        }
                    }
                }
                Group{
                    if mainStatusHelper.activeCharacter != nil {
                        Group{
                            ActiveCharacterCardView(character: mainStatusHelper.activeCharacter!)
                            // MARK: And offer the user the ability to add a new entry with that character.
                            // MARK: Or, if previous entries exists, display a means to see that view.
                        }
                    } else {
                        Group{
                            if mainStatusHelper.settings.count > 0 && mainStatusHelper.backgrounds.count > 0 &&  mainStatusHelper.roles.count > 0 && mainStatusHelper.descriptors.count > 0{
                                Group{
                                    VStack{
                                        SettingsButtonUIView()
                                    // MARK: If there's no active character, give the user a link to create one.
                                    NavigationLink(destination: CreateACharacterView(settings: mainStatusHelper.settings,
                                                                                     backgrounds:mainStatusHelper.backgrounds,
                                                                                     roles: mainStatusHelper.roles,
                                                                                     descriptors: mainStatusHelper.descriptors)){
                                        Text("Create a Character").pulsarFont(style: .primaryButton).foregroundColor(Color.pink)
                                    }
                                    }
                                }
                            }else{
                                Group{
                                   LoadingUIView()
                                }
                            }
                            
                        }
                    }
                }
                Group{
                    CharacterListView(characters: mainStatusHelper.nonActiveCharacters)
                }
            }
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear( perform: {
            authtenticationHelper.refreshAutenticationInfo()
            self.getPlayerCharacterData(getPlayerCharacterDataCompletionHandler: { response, error in
                if error != nil{
                    print(error as Any)
                    let connectionError: Error = PulsarError.connectionError
                    print(connectionError.localizedDescription)
                }else{
                    parsePlayerCharacterData(data: response!.data)
                }
            })
        })
    }
}
