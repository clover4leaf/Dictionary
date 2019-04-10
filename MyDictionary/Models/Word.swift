//
//  Word.swift
//  MyDictionary
//
//  Created by Kirill on 1/29/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import RealmSwift

class Word: Object {
    @objc dynamic var word: String = ""
    var definitions = List<String>()
}
