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
    @IBOutlet private weak var defLabel: UILabel!
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var colorCellView: UIView!

    // MARK: - Privates
    private var colorsArray = [UIColor]()

    // MARK: - Cell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        cellView.layer.cornerRadius = 10.0
        cellView.clipsToBounds = true

        let backgroundColor = getColorWith(red: 80.0, green: 88.0, blue: 112.0)
        let purple = getColorWith(red: 180.0, green: 104.0, blue: 193.0)
        let green = getColorWith(red: 83.0, green: 158.0, blue: 61.0)
        let orange = getColorWith(red: 238.0, green: 163.0, blue: 47.0)
        let red = getColorWith(red: 230.0, green: 82.0, blue: 82.0)

        colorsArray = [purple, green, orange, red]

        self.contentView.backgroundColor = backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

    // MARK: - Public functions
    func configureCellWith(def: String) {
        defLabel.text = def
    }

    func chooseColorForCell(index: Int) {
        let arrayLength = colorsArray.count
        var cellIndex = index
//
//        if index >= arrayLength {
//            colorCellView.backgroundColor = colorsArray[index - arrayLength]
//        } else {
//            colorCellView.backgroundColor = colorsArray[index]
//        }
        while cellIndex >= arrayLength {
            cellIndex -= arrayLength

            if cellIndex >= arrayLength {
                continue
            } else {
                colorCellView.backgroundColor = colorsArray[cellIndex]
                return
            }
        }
        
        colorCellView.backgroundColor = colorsArray[cellIndex]
    }

    func getColorWith(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        let color = UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
        return color
    }
}
