//
//  CustomTVC.swift
//  MyDictionary
//
//  Created by Kirill on 1/30/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class CustomTVC: UITableViewCell {

    // MARK: - Privates
    private var colorsArray = [UIColor]()

    // MARK: - Outlets
    @IBOutlet private weak var cellLabel: UILabel!
    @IBOutlet private weak var backgroundCellView: UIView!
    @IBOutlet private weak var colorCellView: UIView!

    // MARK: - Cell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        let purple = UIColor.purpleColor()
        let green = UIColor.greenColor()
        let orange = UIColor.orangeColor()
        let red = UIColor.redColor()

        colorsArray = [purple, green, orange, red]

        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let backgroundColor = selected ? UIColor.gray : UIColor.white

        backgroundCellView.backgroundColor = backgroundColor
    }

    // MARK: - Private functions
    func configureCellWith(text: String, fontSize: CGFloat) {
        cellLabel.text = text

        let font = UIFont(name: "Helvetica-Light", size: fontSize)
        cellLabel.font = font
    }

    func chooseColorForCell(index: Int) {
        var cellIndex = index

        while cellIndex >= colorsArray.count {
            cellIndex -= colorsArray.count

            if cellIndex >= colorsArray.count {
                continue
            } else {
                colorCellView.backgroundColor = colorsArray[cellIndex]
                return
            }
        }

        colorCellView.backgroundColor = colorsArray[cellIndex]
    }

    // MARK: - Private functions
    private func setupUI() {
        backgroundCellView.layer.cornerRadius = 10.0
        backgroundCellView.clipsToBounds = true

        self.contentView.backgroundColor = UIColor.backgroundColor()
    }
}
