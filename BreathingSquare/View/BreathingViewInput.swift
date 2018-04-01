//
//  BreathingViewInput.swift
//  BreathingSquare
//
//  Created by Oleksii Huralnyk on 3/31/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import Foundation

protocol BreathingViewInput: class {
    
    func setupInitialState()
    func runPreCycleAnimation()
    func runCycleAnimation(viewModels: [BreathingPhaseViewModel])
    func update(phaseTitle: String)
    func update(phaseTimeLeft: String)
    func update(cycleTimeLeft: String)
    
}
