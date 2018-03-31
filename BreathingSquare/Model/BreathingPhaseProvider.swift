//
//  BreathingPhaseProvider.swift
//  BreathingSquare
//
//  Created by Oleksii Huralnyk on 3/31/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import Foundation

protocol BreathingPhaseProviderProtocol {
    
    func fetchPhases() -> [BreathingPhase]
    
}


class BreathingPhaseProvider: BreathingPhaseProviderProtocol {
    
    let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func fetchPhases() -> [BreathingPhase] {
        guard let path = url, let data = try? Data(contentsOf: path) else {
            return []
        }
        
        return (try? JSONDecoder().decode(Array<BreathingPhase>.self, from: data)) ?? []
    }
    
}
