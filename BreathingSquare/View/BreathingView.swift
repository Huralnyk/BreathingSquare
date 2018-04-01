//
//  BreathingView.swift
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
    
}

protocol BreathingViewOutput {
    
    func onViewLoad()
    func onBreathingViewTap()
    func onPreCycleAnimationEnd()
    func onCycleAnimationEnd()
    
}
