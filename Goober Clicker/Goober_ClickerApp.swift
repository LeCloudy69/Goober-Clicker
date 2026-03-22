//
//  Goober_ClickerApp.swift
//  Goober Clicker
//
//  Created by Not Assigned / ADAGE-154 on 3/3/26.
//

import SwiftUI

@main
struct Goober_ClickerApp: App {
    // 1. Create the single "Source of Truth" for the entire game
    @State private var gameEngine = GameEngine()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // 2. Inject it into the environment so any view can access it
                .environment(gameEngine)
        }
    }
}
