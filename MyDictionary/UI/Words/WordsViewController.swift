//
//  WordsViewController.swift
//  MyDictionary
//
//  Created by Kirill on 4/10/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
//import Realm

class WordsViewController: UIViewController {

    // MARK: Privates
    private var savedWords = [String]()

    // MARK: - Actions
    @IBAction func onAdd(_ sender: Any) {
        let viewId = NewWordViewController.getStringName()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        if let addVC = storyboard.instantiateViewController(withIdentifier: viewId) as? NewWordViewController {
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
        let cellId = CustomTableViewCell.getStringName()
        tableView.register(UINib(nibName: cellId, bundle: nil),
                           forCellReuseIdentifier: cellId)

        setupUI()
//        DBManager.shared.printPath()
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadDataFromDB()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent //???
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

            AlertManager.shared.alertDeleteWord(index: indexPath.row,
                                                word: self.savedWords[indexPath.row],
                                                viewController: self,
                                                completion: {
                                                    self.reloadDataFromDB()
            })

            complection(true)
        }

        action.backgroundColor = .red

        return action
    }

}

// MARK: - TableView
extension WordsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return savedWords.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = CustomTableViewCell.getStringName()

        if let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as? CustomTableViewCell {
            cell.configureCellWith(text: savedWords[indexPath.row], fontSize: 34.0)
            cell.chooseColorForCell(index: indexPath.row)

            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let viewId = DefinitionsViewController.getStringName()

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        if let defVC = storyboard.instantiateViewController(withIdentifier: viewId) as? DefinitionsViewController {
            defVC.word = savedWords[indexPath.row]
            defVC.index = indexPath.row

            self.navigationController?.pushViewController(defVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteActionAt(indexPath: indexPath)
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])

        swipeAction.performsFirstActionWithFullSwipe = false

        return swipeAction
    }

}
