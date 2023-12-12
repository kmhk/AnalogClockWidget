//
//  UserDefaultsManager.swift
//  Clock
//
//  Created by Quentin Beukelman on 29/09/2023.
//

import Foundation

struct UserDefaultsManager {
    private static let defaults = UserDefaults.standard
    private static let selectedFontFamilyKey = "selectedFontFamily"
    
    let appGroupUserDefaults = UserDefaults(suiteName: "group.Qb.Clock")?.synchronize()
    
    static var selectedFontFamily: String? {
        get {
            return defaults.string(forKey: selectedFontFamilyKey)
        }
        set {
            defaults.set(newValue, forKey: selectedFontFamilyKey)
            defaults.synchronize()
        }
    }
}
