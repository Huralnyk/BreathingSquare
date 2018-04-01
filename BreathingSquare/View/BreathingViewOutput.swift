//
//  BreathingViewOutput.swift
//  BreathingSquare
//
//  Created by Oleksii Huralnyk on 4/1/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import Foundation

protocol BreathingViewOutput {
    
    func onViewLoad()
    func onBreathingViewTap()
    func onPreCycleAnimationEnd()
    func onPhaseAnimationStart(phase: BreathingPhaseViewModel)
    func onPhaseAnimationEnd(phase: BreathingPhaseViewModel)
    func onCycleAnimationEnd()
    
}
