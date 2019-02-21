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
    @IBOutlet private weak var saveButton: UIButton!

    // MARK: - Actions
    @IBAction func onSave(_ sender: Any) {
        if let word = textField.text {
            DictionaryManager.findTheDifinitionOf(word: word) { (array, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                if let array = array {
                    if array.isEmpty {
                        UIAlertController.alertNoSuch(word: word, viewController: self)
                        return
                    }

                    let defArray = DBManager.shared.arrayToListConverter(array: array)

                    let wordObject = Word()

                    wordObject.word = word
                    wordObject.definitions = defArray

                    DBManager.shared.saveWordWith(object: wordObject)

                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self

        setupUI()
    }

    // MARK: - Private functions
    private func setupUI() {
        self.view.backgroundColor = UIColor.backgroundColor()
        saveButton.layer.backgroundColor = UIColor.redColor().cgColor
        saveButton.layer.cornerRadius = 5.0
        saveButton.layer.masksToBounds = true
        saveButton.clipsToBounds = true
    }
}

// MARK: - UITextFieldDelegate
extension NewWordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
