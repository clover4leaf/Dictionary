//
//  Helper.swift
//  MyDictionary
//
//  Created by Kirill on 1/30/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIColor
extension UIColor {
    class func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        let color = UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
        return color
    }

    class func backgroundColor() -> UIColor {
        let backgroundColor = UIColor.rgb(red: 80.0, green: 88.0, blue: 112.0)
        return backgroundColor
    }

    class func purpleColor() -> UIColor {
        let purpleColor = UIColor.rgb(red: 180.0, green: 104.0, blue: 193.0)
        return purpleColor
    }

    class func greenColor() -> UIColor {
        let greenColor = UIColor.rgb(red: 83.0, green: 158.0, blue: 61.0)
        return greenColor
    }

    class func orangeColor() -> UIColor {
        let orangeColor = UIColor.rgb(red: 238.0, green: 163.0, blue: 47.0)
        return orangeColor
    }

    class func redColor() -> UIColor {
        let redColor = UIColor.rgb(red: 230.0, green: 82.0, blue: 82.0)
        return redColor
    }
}

// MARK: - UIAlertController
extension UIAlertController {
    class func alertNoSuch(word: String, viewController: UIViewController) {
        let title = "Sorry"
        let message = "There is no such word as: '\(word)'"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)

        alert.addAction(okAction)

        viewController.present(alert, animated: true, completion: nil)
    }

    class func alertDeleteWord(index: Int, word: String, viewController: UIViewController, completion: @escaping () -> Void) {
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
