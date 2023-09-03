//
//  RecordManager.swift
//  AstonSpaceProject
//
//  Created by Artem Tkachev on 27.08.23.
//

import Foundation

enum RecordKey: String {
    case recordKey
}

class RecordManager {
    
    static let shared = RecordManager()
    
    func saveRecord(_ record: Record) {
        
        var array = self.loadRecords()
        array.append(record)
        UserDefaults.standard.set(encodable: array, forKey: RecordKey.recordKey.rawValue)
        
    }
    
    func loadRecords() -> [Record] {
        guard let records = UserDefaults.standard.value([Record].self, forKey: RecordKey.recordKey.rawValue) else {
            return []
        }
        return records
    }
}
