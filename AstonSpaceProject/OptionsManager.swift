//
//  OptionsManager.swift
//  AstonSpaceProject
//
//  Created by Artem Tkachev on 23.08.23.
//

import Foundation

enum OptionsKeys: String {
    case optionsKey
}

class OptionsManager {
    
    static let shared = OptionsManager()
    
    private init() {}
    
    func saveOptions(_ options: Options) {
        UserDefaults.standard.set(encodable: options, forKey: OptionsKeys.optionsKey.rawValue)
    }
    
    func loadOptions() -> Options {
        guard let options = UserDefaults.standard.value(Options.self, forKey: OptionsKeys.optionsKey.rawValue) else {
            return Options(playerName: nil, rocketColor: nil, difficulty: nil)
        }
        return options
    }
}
