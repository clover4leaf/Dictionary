//
//  DefinitionVC.swift
//  MyDictionary
//
//  Created by Kirill on 1/29/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class DefinitionVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Publics
    var word = String()
    var index = Int()

    // MARK: - Privates
    private var defArray = [String]()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        self.navigationItem.title = word

        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAction))
        self.navigationItem.rightBarButtonItem = deleteItem

        defArray = DBManager.shared.getDefinitionOf(wordIndex: index)
    }

    // MARK: - Private functions
    @objc private func deleteAction() {
        let title = "Delete?"
        let message = "Are you sure you want to delete the word: \(word)"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            DBManager.shared.deleteItemAt(index: self.index)
            self.navigationController?.popViewController(animated: true)
        }

        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)

        alert.addAction(yesAction)
        alert.addAction(noAction)

        present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableView
extension DefinitionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return defArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "defCell"

        if let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as? DefinitionTVC {
            cell.configureCellWith(def: defArray[indexPath.section])

            return cell
        }

        return UITableViewCell()
    }
}
