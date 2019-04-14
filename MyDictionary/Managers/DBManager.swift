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
import ObjectMapper

class DBManager {

    // MARK: - Publics
    static let shared = DBManager()

    // MARK: - Privates
    private init() {}

    func printPath() {
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "NO_URL")
    }

    func arrayToListConverter(array: [String]) -> List<String> {
        let list = List<String>()

        array.forEach { (item) in
            list.append(item)
        }

        return list
    }

    func saveWord(with word: Word) {
        if let realm = try? Realm() {
            try? realm.write {
                realm.add(word)
            }
        }
    }

    func delete(word: Word) {
        if let realm = try? Realm() {
            try? realm.write {
                realm.delete(word)
//                realm.deleteAll()
            }
        }
    }

    func getSavedWords() -> Results<Word>? {
        if let realm = try? Realm() {
            let wordsArray = realm.objects(Word.self)
            return wordsArray
        }

        return nil
    }
}
