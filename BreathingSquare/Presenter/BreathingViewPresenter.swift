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
    let timerFormatter: TimerFormatter
    weak var view: BreathingViewInput?
    
    private weak var timer: Timer?
    private var totalTimeElapsed = 0.0
    private var phaseTimeElapsed = 0.0
    private var totalDuration = 0.0
    private var currentPhase: BreathingPhaseViewModel?
    
    init(provider: BreathingPhaseProviderProtocol, view: BreathingViewInput?, timerFormatter: TimerFormatter = DefaultTimerFormatter()) {
        self.provider = provider
        self.timerFormatter = timerFormatter
        self.view = view
    }
    
}

// MARK: - View Output
extension BreathingViewPresenter: BreathingViewOutput {
    
    func onViewLoad() {
        view?.setupInitialState()
    }
    
    func onBreathingViewTap() {
        view?.runPreCycleAnimation()
    }
    
    func onPreCycleAnimationEnd() {
        let phases = provider.fetchPhases()
        let viewModels = phases.flatMap(BreathingPhaseViewModel.init(phase:))
        totalDuration = phases.reduce(0, { $0 + $1.duration })
        view?.runCycleAnimation(viewModels: viewModels)
        startCycleAnimationTimer()
        updateLabels()
    }
    
    func onPhaseAnimationStart(phase: BreathingPhaseViewModel) {
        currentPhase = phase
        phaseTimeElapsed = 0
        updateLabels()
    }
    
    func onPhaseAnimationEnd(phase: BreathingPhaseViewModel) {
        
    }
    
    func onCycleAnimationEnd() {
        totalTimeElapsed = 0
        view?.setupInitialState()
    }
    
}

// MARK: - Private Methods
extension BreathingViewPresenter {
    
    private func startCycleAnimationTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFire), userInfo: nil, repeats: true)
    }
    
    private func stopCycleAnimationTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func onTimerFire() {
        totalTimeElapsed += 1
        phaseTimeElapsed += 1
        updateLabels()
        if totalTimeElapsed >= totalDuration {
            stopCycleAnimationTimer()
        }
    }
    
    private func updateLabels() {
        guard let phase = currentPhase else { return }
        let totalTimeLeft = totalDuration - totalTimeElapsed
        let phaseTimeLeft = phase.duration - phaseTimeElapsed
        view?.update(cycleTimeLeft: timerFormatter.string(from: totalTimeLeft))
        view?.update(phaseTimeLeft: timerFormatter.string(from: phaseTimeLeft))
        view?.update(phaseTitle: phase.type.rawValue.uppercased())
    }
    
}
