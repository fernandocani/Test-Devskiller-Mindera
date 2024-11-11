//
//  Int+Extension.swift
//  Devskiller
//
//  Created by Fernando Cani on 10/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

extension Int {
    func formatLargeNumber() -> String {
        let trillion = 1_000_000_000_000
        let billion = 1_000_000_000
        let million = 1_000_000
        let thousand = 1_000
        
        switch self {
        case trillion...:
            return String(format: "%.0fT", Double(self) / Double(trillion))
        case billion...:
            return String(format: "%.0fB", Double(self) / Double(billion))
        case million...:
            return String(format: "%.0fM", Double(self) / Double(million))
        case thousand...:
            return String(format: "%.0fK", Double(self) / Double(thousand))
        default:
            return "\(self)"
        }
    }
}
