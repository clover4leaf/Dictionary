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

    static let shared = AlertManager()

    private init() {}

    func alertNoSuch(word: String, viewController: UIViewController) {
        let title = "Sorry"
        let message = "There is no such word as: '\(word)'"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)

        alert.addAction(okAction)

        viewController.present(alert, animated: true, completion: nil)
    }

    func alertDeleteWord(index: Int, word: String, viewController: UIViewController, completion: @escaping () -> Void) {
        let title = "Delete?"
        let message = "Are you sure you want to delete the word: \(word)"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            DBManager.shared.deleteItemAt(index: index, completion: {
            })
            completion()
        }

        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)

        alert.addAction(yesAction)
        alert.addAction(noAction)

        viewController.present(alert, animated: true, completion: nil)
    }

}
