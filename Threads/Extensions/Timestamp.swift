//
//  Timestamp.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 26/07/24.
//

import Firebase

extension Timestamp {
    func toString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        
        return formatter.string(from: self.dateValue(), to: Date()) ?? ""
    }
}
