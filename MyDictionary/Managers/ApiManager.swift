//
//  DictionaryManager.swift
//  MyDictionary
//
//  Created by Kirill on 1/29/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

final class ApiManager {

    // MARK: - Publics
    static let shared = ApiManager()

    // MARK: - Privates
    private let apiKey = "4a094234-ac81-4e51-a47b-7fae57e869de"

    // MARK: - Initializers
    private init() {}

    // MARK: - Public functions
    func findDifinitionOf(word: String, completion: @escaping ([WordMappable]?, Error?) -> Void) {
        // check the word before doing the request
        guard let url = try? "https://dictionaryapi.com/api/v3/references/sd2/json/\(word)".asURL() else {
            completion(nil, nil)
            return
        }

        let parametres = [
            "key": apiKey
        ]

        request(url, method: .get, parameters: parametres).validate().responseString { (responseString) in
            switch responseString.result {
            case .success(let value):
                let wordMappable = Mapper<WordMappable>().mapArray(JSONString: value)
                completion(wordMappable, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
