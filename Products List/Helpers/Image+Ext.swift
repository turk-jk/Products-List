//
//  Image+Ext.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import SwiftUI

enum ImageName: String {
    case heart = "heart"
    case listDash = "list.dash"

}

extension Image{
    init(name: ImageName) {
        self.init(systemName: name.rawValue)
    }
}
