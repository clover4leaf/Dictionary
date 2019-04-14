//
//  AlertManager.swift
//  MyDictionary
//
//  Created by Kirill on 4/10/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import UIKit

final class AlertManager {

    private init() {}

    class func alertNoSuch(word: String,
                           viewController: UIViewController) {
        let title = "Sorry"
        let message = "There is no such word as: '\(word)'. \nBe sure that it is only ONE word, and there is no SPACES"

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok",
                                     style: .cancel,
                                     handler: nil)

        alert.addAction(okAction)

        viewController.present(alert,
                               animated: true,
                               completion: nil)
    }

    class func alertDeleteWord(
                               word: Word,
                               viewController: UIViewController,
                               completion: @escaping () -> Void) {
        let title = "Delete?"
        let message = "Are you sure you want to delete the word: \(word)"

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes",
                                      style: .default) { (_) in
                                        DBManager.shared.delete(word: word)
//                                        DBManager.shared.deleteItemAt(index: index)
                                        completion()
        }

        let noAction = UIAlertAction(title: "No",
                                     style: .cancel,
                                     handler: nil)

        alert.addAction(yesAction)
        alert.addAction(noAction)

        viewController.present(alert,
                               animated: true,
                               completion: nil)
    }

}
