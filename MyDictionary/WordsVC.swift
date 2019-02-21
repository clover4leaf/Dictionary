//
//  WordsVC.swift
//  MyDictionary
//
//  Created by Kirill on 1/29/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
import RealmSwift
//import Realm

class WordsVC: UIViewController {

    // MARK: Privates
    private var savedWords = [String]()

    // MARK: - Actions
    @IBAction func onAdd(_ sender: Any) {
        let viewId = "newWordScreen"
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        if let addVC = storyboard.instantiateViewController(withIdentifier: viewId) as? NewWordVC {
            self.navigationController?.pushViewController(addVC, animated: true)
        }
    }

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTVC", bundle: nil), forCellReuseIdentifier: "customCell")

        setupUI()
        DBManager.shared.printPath()
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadDataFromDB()
    }

    // MARK: - Private functions
    private func setupUI() {
        self.navigationItem.title = "Words"

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.backgroundColor()

        self.view.backgroundColor = UIColor.backgroundColor()
    }

    private func reloadDataFromDB() {
        savedWords = DBManager.shared.getSavedWords()
        self.tableView.reloadData()
    }

    private func deleteActionAt(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Delete") { (_, _, complection) in

            UIAlertController.alertDeleteWord(index: indexPath.row,
                                              word: self.savedWords[indexPath.row],
                                              viewController: self, completion: {
                                                self.reloadDataFromDB()
            })

            complection(true)
        }

        action.backgroundColor = .red

        return action
    }
}

// MARK: - TableView
extension WordsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWords.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "customCell"

        if let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as? CustomTVC {
            cell.configureCellWith(text: savedWords[indexPath.row], fontSize: 34.0)
            cell.chooseColorForCell(index: indexPath.row)

            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewId = "definitionsScreen"

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        if let defVC = storyboard.instantiateViewController(withIdentifier: viewId) as? DefinitionVC {
            defVC.word = savedWords[indexPath.row]
            defVC.index = indexPath.row

            self.navigationController?.pushViewController(defVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteActionAt(indexPath: indexPath)
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])

        swipeAction.performsFirstActionWithFullSwipe = false

        return swipeAction
    }
}
