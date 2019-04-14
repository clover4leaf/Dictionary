//
//  WordsPresenter.swift
//  MyDictionary
//
//  Created by Kirill on 4/12/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import UIKit

protocol WordsPresenterProtocol: class {
    init(view: WordsViewProtocol)

    var numberOfWords: Int { get }
    func showWords()
    func addAction()
    func reloadDataFromDB()
}

class WordsPresenter: WordsPresenterProtocol {

    private var view: WordsViewProtocol
    private var words: [Word] = []

    var numberOfWords: Int {
        return words.count
    }

    required init(view: WordsViewProtocol) {
        self.view = view
    }

    func showWords() {
    }

    func addAction() {
        let viewId = NewWordViewController.getStringName()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        if let addVC = storyboard.instantiateViewController(withIdentifier: viewId) as? NewWordViewController {
            if let viewController = self.view as? WordsViewController {
                viewController.navigationController?.pushViewController(addVC, animated: true)
            }
        }
    }

    func reloadDataFromDB() {
//        words = DBManager.shared.getSavedWords()
        view.reloadData()
    }

}
