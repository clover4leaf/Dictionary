//
//  Extension+UIColor.swift
//  MyDictionary
//
//  Created by Kirill on 4/10/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

extension UIColor {

    class func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        let color = UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
        return color
    }

    class func backgroundColor() -> UIColor {
        let backgroundColor = UIColor.rgb(red: 80.0, green: 88.0, blue: 112.0)
        return backgroundColor
    }

    class func purpleColor() -> UIColor {
        let purpleColor = UIColor.rgb(red: 180.0, green: 104.0, blue: 193.0)
        return purpleColor
    }

    class func greenColor() -> UIColor {
        let greenColor = UIColor.rgb(red: 83.0, green: 158.0, blue: 61.0)
        return greenColor
    }

    class func orangeColor() -> UIColor {
        let orangeColor = UIColor.rgb(red: 238.0, green: 163.0, blue: 47.0)
        return orangeColor
    }

    class func redColor() -> UIColor {
        let redColor = UIColor.rgb(red: 230.0, green: 82.0, blue: 82.0)
        return redColor
    }

}
