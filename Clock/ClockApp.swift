//
//  ClockApp.swift
//  Clock
//
//  Created by Quentin Beukelman on 21/01/2023.
//

import SwiftUI

@main
struct ClockApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
