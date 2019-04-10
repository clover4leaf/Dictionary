//
//  Extension+NSObject.swift
//  MyDictionary
//
//  Created by Kirill on 4/10/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation

extension NSObject {

    class func getStringName() -> String {
        return String(describing: self.self)
    }

}
