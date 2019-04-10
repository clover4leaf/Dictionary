//
//  WordMappable.swift
//  MyDictionary
//
//  Created by Kirill on 4/10/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import ObjectMapper

final class WordMappable: Mappable {

    var shortdef: [String]?

    required init?(map: Map) {
        shortdef = try? map.value("shortdef")
    }

    func mapping(map: Map) {
        shortdef <- map["shortdef"]
    }

}
