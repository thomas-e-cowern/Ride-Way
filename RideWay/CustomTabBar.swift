//
//  CustomTabBar.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/21/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = 90
        return size
    }
}
