//
//  BreathingViewPresenter.swift
//  BreathingSquare
//
//  Created by Oleksii Huralnyk on 3/31/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import Foundation


class BreathingViewPresenter {
    
    let provider: BreathingPhaseProviderProtocol
    weak var view: BreathingViewInput?
    
    init(provider: BreathingPhaseProviderProtocol, view: BreathingViewInput?) {
        self.provider = provider
        self.view = view
    }
    
}


extension BreathingViewPresenter: BreathingViewOutput {
    
    func onViewLoad() {
        let phases = provider.fetchPhases()
        
    }
    
}