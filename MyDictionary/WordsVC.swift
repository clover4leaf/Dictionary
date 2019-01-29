//
//  WordsVC.swift
//  MyDictionary
//
//  Created by Kirill on 1/29/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
import RealmSwift

class WordsVC: UIViewController {

    // MARK: - Actions
    @IBAction func onAdd(_ sender: Any) {
        let viewId = "newWordScreen"
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        if let addVC = storyboard.instantiateViewController(withIdentifier: viewId) as? NewWordVC {
            self.navigationController?.pushViewController(addVC, animated: true)
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Privates
    private var savedWords = [String]()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

//        DBManager.shared.printPath()
    }

    override func viewWillAppear(_ animated: Bool) {
        savedWords = DBManager.shared.getSavedWords()

        self.tableView.reloadData()
    }
}

// MARK: - TableView
extension WordsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "wordCell"

        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId)

        cell?.textLabel?.text = savedWords[indexPath.row]

        return cell!
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

}
