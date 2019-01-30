//
//  DictionaryManager.swift
//  MyDictionary
//
//  Created by Kirill on 1/29/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation

final class DictionaryManager {

    // MARK: - Initializers
    private init() {}

    // MARK: - Class func
    class func findTheDifinitionOf(word: String, complition: @escaping ([String]?, Error?) -> Void) {
        // check the word before doing the request
        let apiKey = "4a094234-ac81-4e51-a47b-7fae57e869de"

        let url: URL = URL(string: "https://dictionaryapi.com/api/v3/references/sd2/json/\(word)?key=\(apiKey)")!
        let request = URLRequest(url: url)

        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)

        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                complition([], error)
                return
            }

            if let data = data {
                if let responseDictionary = try? JSONSerialization.jsonObject(with: data, options:[]) as? [NSDictionary] {
                    var requestArray = [String]()

                    guard let length = responseDictionary?.count else {
                        complition([], nil)
                        return
                    }

                    for response in 0..<length {
                        if let shortdefField = responseDictionary?[response].value(forKey: "shortdef") as? [String] {
                            for shortdef in 0..<shortdefField.count {
                                requestArray.append(shortdefField[shortdef])
                            }
                        }
                    }

                    complition(requestArray, nil)
                    return
                }
            }

            complition([], nil)
        });
        task.resume()
    }
}
