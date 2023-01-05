//
//  Color+Ext.swift
//  TestTask2023
//
//  Created by JkPhTrue Just on 05.01.2023.
//

import Foundation
import SwiftUI

enum AppColor: String {
    case green
    case grey
    case cyan
    case greenLight
    case cyanLight
}

extension Color {
    init(_ appColor: AppColor) {
        self.init(appColor.rawValue)
    }
}
