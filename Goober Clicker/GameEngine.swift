//
//  GameEngine.swift
//  Goober Clicker
//
//  Created by Not Assigned / ADAGE-154 on 3/21/26.
//

import Foundation

import SwiftUI
import Observation // Required for @Observable in iOS 17+

@Observable
class GameEngine {
    var tapCount: Int = 0
    
    var upgrades: [Upgrade] = []
    
    init() {
        loadGame()
    }
    
    // MARK: - Game Logic
    func buyUpgrade(id: String) {
        // Find the index of the upgrade the player tapped
        if let index = upgrades.firstIndex(where: { $0.id == id }) {
            let upgrade = upgrades[index]
            
            if tapCount >= upgrade.currentCost {
                tapCount -= upgrade.currentCost
                upgrades[index].level += 1
            }
            saveGame()
        }
    }
    
    func clickGoober() {
        tapCount += 1
        saveGame()
    }
    
    // MARK: - Debug / Reset
        func resetGame() {
            // 1. Reset the live variables back to their defaults
            self.tapCount = 0
            self.upgrades = [
                Upgrade(id: "click_power", name: "Cursor Enhancer", description: "+1 per tap", baseCost: 10, multiplier: 1.5),
                Upgrade(id: "auto_farm", name: "Goober Farm", description: "Auto-generates", baseCost: 50, multiplier: 1.8),
                Upgrade(id: "factory", name: "Goober Factory", description: "Mass production", baseCost: 500, multiplier: 2.0)
            ]
            saveGame()
        }
    
    // MARK: - Persistence
    private func saveGame() {
        UserDefaults.standard.set(tapCount, forKey: "tapCount")
        
        if let encodedData = try? JSONEncoder().encode(upgrades) {
            UserDefaults.standard.set(encodedData, forKey: "savedUpgrades")
        }
    }
    
    private func loadGame() {
            self.tapCount = UserDefaults.standard.integer(forKey: "tapCount")
            
            if let savedData = UserDefaults.standard.data(forKey: "savedUpgrades"),
               let decodedUpgrades = try? JSONDecoder().decode([Upgrade].self, from: savedData),
               !decodedUpgrades.isEmpty {
                self.upgrades = decodedUpgrades
            } else {
                // First time or empty save, Initialize the default upgrade list
                self.upgrades = [
                    Upgrade(id: "click_power", name: "Cursor Enhancer", description: "+1 per tap", baseCost: 10, multiplier: 1.5),
                    Upgrade(id: "auto_farm", name: "Goober Farm", description: "Auto-generates", baseCost: 50, multiplier: 1.8),
                    Upgrade(id: "factory", name: "Goober Factory", description: "Mass production", baseCost: 500, multiplier: 2.0)
                ]
            }
            saveGame()
        }
}
