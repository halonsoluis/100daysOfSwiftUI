// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import Foundation
import SwiftUI

struct Project: Identifiable {
    let id: String
    let mainWindow: ()-> any View
}

extension Project {
    private static var weSplit: (String, WeSplit) {
        ("WeSplit", .init())
    }

    enum projects: String, CaseIterable {
        case weSplit

        var view: any View {
            switch self {
            case .weSplit: return WeSplit()
            }
        }
    }
}
