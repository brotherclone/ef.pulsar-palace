//
//  AuthoringView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/22/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI
import Moya
import SwiftyJSON

class PromptForEntryHelper: ObservableObject{
    @Published var prompt: Prompt? = nil
    @Published var characterEntries: [Entry]? = nil
    @Published var entrySubmitted: Bool = false
}

struct AuthoringView: View {
    
    @ObservedObject var authenticationHelper = AuthenticationHelper()
    @ObservedObject var promptForEntryHelper = PromptForEntryHelper()
    
    var character: Character
    
    @State var inputEntryText: String = ""
    
    func getEntriesForCharacter(characterId: Int, getEntriesForCharacterCompletionHander: @escaping (Response?, Error?) -> Void){
        let networkProvider = NetworkManager.provider
        networkProvider.request(.getEntriesByCharacter(characterId: characterId)){ result in
            switch result {
            case let .success(moyaResponse):
                getEntriesForCharacterCompletionHander(moyaResponse, nil)
            case let .failure(error):
                getEntriesForCharacterCompletionHander(nil, error)
            }
        }
    }
    
    func parseEntries(data: Data){
        do{
            let json = try JSON(data:data)
            if let entries: [Any] = json["entries"].array{
                var characterEntries: [Entry] = []
                for entry in entries {
                    let anEntry: Entry = entry as! Entry
                    characterEntries.append(anEntry)
                }
                lastEntryForPrompts(entries: characterEntries)
            }
        } catch {
            let error: Error = PulsarError.parsingError
            print(error.localizedDescription)
        }
    }
    
    func lastEntryForPrompts(entries: [Entry]){
        promptForEntryHelper.characterEntries = entries
        let lastEntry = entries.last
        getPrompt(lastEntryId: lastEntry!.id!, getPromptCompletionHandler: { response, error in
            if error != nil{
                print(error as Any)
                let connectionError: Error = PulsarError.connectionError
                print( connectionError.localizedDescription)
            }else{
                do{
                    let json = try JSON(data: response!.data)
                    if let promptData: Any = json["prompt"].dictionaryObject {
                        if let prompt: Prompt = promptData as? Prompt{
                            promptForEntryHelper.prompt = prompt
                        }
                    }
                }catch{
                    let error: Error = PulsarError.parsingError
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    func prepEntry(entryText: String, character: Character) -> Entry{
        
        return Entry(entry_text: entryText,
                     prompt_id: promptForEntryHelper.prompt!.id,
                     character_id: character.id!)
    }
    
    
    func postEntry(entry: Entry, postEntryCompletionHandler: @escaping (Response?, Error?) -> Void?){
        let networkProvider = NetworkManager.provider
        networkProvider.request(.createEntry(entry: entry)) { result in
            switch result{
            case let .success(moyaResponse):
                postEntryCompletionHandler(moyaResponse, nil)
            case let .failure(error):
                postEntryCompletionHandler(nil, error)
            }
        }
    }
    
    func updateCharacter(character: Character, updateCharacterCompletionHandler: @escaping (Response?, Error?) -> Void?){
        let networkProvider = NetworkManager.provider
        networkProvider.request(.updateCharacter(character: character)) { result in
            switch result{
            case let .success(moyaResponse):
                updateCharacterCompletionHandler(moyaResponse, nil)
            case let .failure(error):
                updateCharacterCompletionHandler(nil, error)
            }
        }
    }
    
    
    func getPrompt(lastEntryId: Int, getPromptCompletionHandler: @escaping (Response?, Error?) -> Void){
        let networkProvider = NetworkManager.provider
        networkProvider.request(.getPrompt(lastEntryId:  lastEntryId)) { result in
            switch result{
            case let .success(moyaResponse):
                getPromptCompletionHandler(moyaResponse, nil)
            case let .failure(error):
                getPromptCompletionHandler(nil, error)
            }
        }
    }
    
    var body: some View {
        Group{
            Text("Authoring")
            // MARK: Make some type of reaction to the prompt here.
            NavigationLink(destination: ResultsView(character:character, prompt:promptForEntryHelper.prompt!), isActive: $promptForEntryHelper.entrySubmitted){}
            Group{
                if promptForEntryHelper.prompt != nil{
                    Group{
                        Text(promptForEntryHelper.prompt!.prompt_title)
                        Text(promptForEntryHelper.prompt!.prompt_text)
                        TextField("Entry", text: $inputEntryText)
                        Button(action:{
                            let anEntry: Entry = self.prepEntry(entryText: inputEntryText, character: character)
                            self.postEntry(entry: anEntry, postEntryCompletionHandler:{ response, error in
                                if error == nil{
                                    print(error as Any)
                                    let connectionError: Error = PulsarError.connectionError
                                    print( connectionError.localizedDescription)
                                }else{
                                    promptForEntryHelper.entrySubmitted = true
                                }
                                return nil
                            })
                            
                        }){
                            Text("Send Entry")
                        }
                    }
                }
            }
        }.onAppear(perform: {
            self.getEntriesForCharacter(characterId: character.id!, getEntriesForCharacterCompletionHander: { response, error in
                if error != nil{
                    print(error as Any)
                    let connectionError: Error = PulsarError.connectionError
                    print( connectionError.localizedDescription)
                }else{
                    self.parseEntries(data: response!.data)
                }
            })
        })
    }
}
