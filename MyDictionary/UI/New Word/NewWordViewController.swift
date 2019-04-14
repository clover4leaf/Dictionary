//
//  NewWordViewController.swift
//  MyDictionary
//
//  Created by Kirill on 4/10/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class NewWordViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Private functions
    private func setupUI() {
        // Background View
        self.view.backgroundColor = UIColor.backgroundColor()

        // Textfield
        textField.delegate = self
        textField.becomeFirstResponder()

        // Button
        saveButton.addTarget(self,
                             action: #selector(saveAction),
                             for: .touchUpInside)
        saveButton.layer.backgroundColor = UIColor.redColor().cgColor
        saveButton.layer.cornerRadius = 5.0
        saveButton.layer.masksToBounds = true
        saveButton.clipsToBounds = true
    }

    // MARK: - Selectors
    @objc private func saveAction() {
        if let word = textField.text {
            ApiManager.shared.findDifinitionOf(word: word) { (response, error) in
                if let error = error {
                    print("💥🎩 Error in NewWordViewController - onSave: \(error.localizedDescription)")
                    return
                }

                if let array = response?[0].shortdef {
                    if array.isEmpty || array == [] {
                        AlertManager.alertNoSuch(word: word,
                                                 viewController: self)
                        return
                    }

                    let wordObject = Word()

                    wordObject.word = word

                    let defArray = DBManager.shared.arrayToListConverter(array: array)
                    wordObject.definitions = defArray

                    DBManager.shared.saveWord(with: wordObject)

                    self.navigationController?.popViewController(animated: true)
                } else {
                    AlertManager.alertNoSuch(word: word,
                                             viewController: self)
                }
            }

        }
    }

}

// MARK: - UITextFieldDelegate
extension NewWordViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveAction()
        return true
    }

}
