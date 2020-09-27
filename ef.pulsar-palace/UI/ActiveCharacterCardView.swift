//
//  ActiveCharacterCardView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/22/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI
import Moya
import SwiftyJSON

class EntriesForACharacterHelper: ObservableObject{
    @Published var entries: [Entry]? = []
}

struct ActiveCharacterCardView: View {
    
    var character: Character?
    
    @ObservedObject var entriesForACharacterHelper = EntriesForACharacterHelper()
    
    
    func getEntries(characterId: Int, getEntriesCompletionHandler: @escaping (Response?, Error?) -> Void) {
        let networkProvider = NetworkManager.provider
        networkProvider.request(.getEntriesByCharacter(characterId: characterId)){ result in
            switch result{
            case let .success(moyaResponse):
                getEntriesCompletionHandler(moyaResponse, nil)
            case let .failure(error):
                getEntriesCompletionHandler(nil, error)
            }
        }
    }
    var body: some View {
        Group{
            if character != nil{
                Group{
                    Text(character!.name)
                    Text(character!.additional_bio!)
                    Text(character!.characterBackground!.background)
                    Text(character!.characterRole!.character_role)
                    Text("From \(character!.characterSetting!.time), \(character!.characterSetting!.place)")
                    Text(character!.characterDescriptor!.descriptor)
                    Text("\(character!.current_health) / \(character!.max_health)")
                }
            }
            NavigationLink(destination: AuthoringView(character: character!)){
                Text("Write an Entry")
            }
            if entriesForACharacterHelper.entries!.count >= 1{
                Group{
                    Text("Previous Entries:")
                    EntryListView(character: character!, entries: entriesForACharacterHelper.entries!)
                }
            }
        }.onAppear( perform: {
            if let characterId: Int = character!.id {
                self.getEntries(characterId: characterId, getEntriesCompletionHandler: { response, error in
                    if error != nil{
                        print(error as Any)
                    }else{
                        do{
                            let json = try JSON(data:response!.data)
                            var characterEntries: [Entry] = []
                            if let entries: [Any] = json["entries"].array{
                                for entry in entries{
                                    let anEntry: Entry = entry as! Entry
                                    characterEntries.append(anEntry)
                                }
                                entriesForACharacterHelper.entries = characterEntries
                            }
                        }catch{
                            print("Error Parsing")
                        }
                        
                    }
                })
            }
        })
    }
}

//struct ActiveCharacterCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActiveCharacterCardView()
//    }
//}

// MARK: Show preview with mocks
