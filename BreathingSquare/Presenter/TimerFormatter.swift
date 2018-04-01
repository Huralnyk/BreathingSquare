//
//  TimerFormatter.swift
//  BreathingSquare
//
//  Created by Oleksii Huralnyk on 4/1/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import Foundation

protocol TimerFormatter {
    
    func string(from duration: TimeInterval) -> String
    
}

struct DefaultTimerFormatter: TimerFormatter {
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "mm:ss"
        return formatter
    }()
    
    func string(from duration: TimeInterval) -> String {
        return DefaultTimerFormatter.formatter.string(from: Date(timeIntervalSince1970: duration))
    }
    
}
