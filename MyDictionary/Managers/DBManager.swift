//
//  DBManager.swift
//  MyDictionary
//
//  Created by Kirill on 1/29/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class DBManager {

    // MARK: - Publics
    static let shared = DBManager()

    // MARK: - Privates
    private init() {}

    func printPath() {
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }

    func arrayToListConverter(array: [String]) -> List<String> {
        let list = List<String>()

        array.forEach { (item) in
            list.append(item)
        }

        return list
    }

    func saveWordWith(object: Word) {
        if let realm = try? Realm() {
            try? realm.write {
                realm.add(object)
            }
        }
    }

    func deleteItemAt(index: Int) {
        if let realm = try? Realm() {
            try? realm.write {
                let wordResults = realm.objects(Word.self)

                realm.delete(wordResults[index])
//                realm.deleteAll()
            }
        }
    }

    func getSavedWords() -> [String] {
        if let realm = try? Realm() {
            let wordResults = realm.objects(Word.self)

            var wordsArray = [String]()

            wordResults.forEach { (wordObj) in
                let word = wordObj.word
                wordsArray.append(word)
            }

            return wordsArray
        }

        return []
    }
    
    func getDefinitionOf(wordIndex: Int) -> [String] {
        if let realm = try? Realm() {
            let defResults = realm.objects(Word.self)

            let def = defResults[wordIndex].definitions

            var defArray = [String]()

            def.forEach { (definition) in
                defArray.append(definition)
            }

            return defArray
        }

        return []
    }
}
