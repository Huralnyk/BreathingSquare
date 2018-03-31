//
//  BreathingPhaseViewModel.swift
//  BreathingSquare
//
//  Created by Oleksii Huralnyk on 3/31/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import UIKit

struct BreathingPhaseViewModel {
    
    enum PhaseType: String {
        case inhale
        case exhale
        case hold
    }
    
    var type: PhaseType
    var duration: TimeInterval
    var color: UIColor
    
}


extension BreathingPhaseViewModel {
    
    init?(phase: BreathingPhase) {
        guard let type = PhaseType(rawValue: phase.type), let color = UIColor(hexString: phase.color) else {
            return nil
        }
        
        self.type = type
        self.duration = phase.duration
        self.color = color
    }
    
}
