//
//  NewWordVC.swift
//  MyDictionary
//
//  Created by Kirill on 1/29/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
import RealmSwift

class NewWordVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var textField: UITextField!

    // MARK: - Actions
    @IBAction func onSave(_ sender: Any) {
        if let word = textField.text {
            DictionaryManager.findTheDifinitionOf(word: word) { (array, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                if let array = array {
                    let defArray = DBManager.shared.arrayToListConverter(array: array)

                    let wordObject = Word()

                    wordObject.word = word
                    wordObject.definitions = defArray

                    DBManager.shared.saveWordWith(object: wordObject)
                    print(DBManager.shared.getSavedWords())

                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
}

// MARK: - Textfield
extension NewWordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
