//
//  DefinitionTVC.swift
//  MyDictionary
//
//  Created by Kirill on 1/29/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class DefinitionTVC: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var cellView: UIView!

    // MARK: - Cell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        cellView.layer.cornerRadius = 10.0
        cellView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

    // MARK: - Public functions
    func configureCellWith(def: String) {
        defLabel.text = def
    }
}
