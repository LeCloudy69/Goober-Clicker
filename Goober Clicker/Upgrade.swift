//
//  Upgrade.swift
//  Goober Clicker
//
//  Created by Not Assigned / ADAGE-154 on 3/21/26.
//

import Foundation

struct Upgrade: Identifiable, Codable {
    let id: String           // Unique string id like "auto_clicker_1"
    let name: String         // Display name like "Goober Farm"
    let description: String  // "Generates 1 Goober per second"
    let baseCost: Int
    let multiplier: Double   // How much the cost multiplies per level
    
    var level: Int = 0       // This is the dynamic part that changes
    
    // Computed property: Calculates cost dynamically based on current level
    var currentCost: Int {
        return Int(Double(baseCost) * pow(multiplier, Double(level)))
    }
    
    // Computed property: Calculates production based on level
    var currentProduction: Int {
        // Example: Level 1 = 1/sec, Level 2 = 2/sec. Adjust formula as needed.
        return level > 0 ? level * 1 : 0
    }
}
