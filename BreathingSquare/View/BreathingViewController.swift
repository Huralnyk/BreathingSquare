//
//  BreathingViewController.swift
//  BreathingSquare
//
//  Created by Oleksii Huralnyk on 3/31/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import UIKit

final class BreathingViewController: UIViewController, BreathingViewInput {
    
    private enum Constants {
        static let initialSquareWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.75
        static let initialSquareColor: UIColor = .yellow
        static let preCycleAnimationDuration = 1.0
        static let preCycleSquareWidthRatio: CGFloat = 0.75
    }
    
    @IBOutlet weak var breathingView: UIView?
    @IBOutlet weak var promptLabel: UILabel?
    @IBOutlet weak var phaseTitleLabel: UILabel?
    @IBOutlet weak var phaseTimerLabel: UILabel?
    @IBOutlet weak var cycleTimerTitleLabel: UILabel?
    @IBOutlet weak var cycleTimerLabel: UILabel?
    
    @IBOutlet weak var breathingViewWidth: NSLayoutConstraint?
    
    private var allLabels: [UILabel?] {
        return [promptLabel, phaseTitleLabel, phaseTimerLabel, cycleTimerTitleLabel, cycleTimerLabel]
    }
    
    private var timerLabels: [UILabel?] {
        return [phaseTitleLabel, phaseTimerLabel, cycleTimerTitleLabel, cycleTimerLabel]
    }
    
    private var output: BreathingViewOutput?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "breathing_cycle", withExtension: "json")
        let provider = BreathingPhaseProvider(url: url)
        output = BreathingViewPresenter(provider: provider, view: self)
        
        output?.onViewLoad()
    }
    
    // MARK: - View Input
    func setupInitialState() {
        breathingView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapBreathingView)))
        allLabels.forEach { $0?.isHidden = true }
        promptLabel?.isHidden = false
        breathingViewWidth?.constant = Constants.initialSquareWidth
        breathingView?.backgroundColor = Constants.initialSquareColor
    }
    
    func runPreCycleAnimation() {
        setupPreCycleState()
        view.layoutIfNeeded()
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: Constants.preCycleAnimationDuration,
            delay: 0.0,
            options: [],
            animations: {
                self.breathingViewWidth?.constant = Constants.initialSquareWidth * Constants.preCycleSquareWidthRatio
                self.view.layoutIfNeeded()
        },
            completion: { _ in
                self.output?.onPreCycleAnimationEnd()
        }
        )
    }
    
    func runCycleAnimation(viewModels: [BreathingPhaseViewModel]) {
        setupRunningCycleState()
        view.layoutIfNeeded()
        
        let animators = viewModels.map(propertyAnimator(phase:))
        for (index, animator) in animators.enumerated() {
            if index == animators.index(before: animators.endIndex) {
                animator.addCompletion { _ in
                    self.output?.onCycleAnimationEnd()
                }
            } else {
                animator.addCompletion { _ in
                    animators[index + 1].startAnimation()
                    self.output?.onPhaseAnimationStart(phase: viewModels[index + 1])
                }
            }
        }
        
        animators.first?.startAnimation()
        viewModels.first.map { output?.onPhaseAnimationStart(phase: $0) }
    }
    
    func update(phaseTitle: String) {
        phaseTitleLabel?.text = phaseTitle
    }
    
    func update(phaseTimeLeft: String) {
        phaseTimerLabel?.text = phaseTimeLeft
    }
    
    func update(cycleTimeLeft: String) {
        cycleTimerLabel?.text = cycleTimeLeft
    }
    
    // MARK: - UI Actions
    @objc private func tapBreathingView(recognizer: UITapGestureRecognizer) {
        output?.onBreathingViewTap()
    }
    
    
    // MARK: - Private Methods
    private func setupPreCycleState() {
        breathingView?.gestureRecognizers = []
        allLabels.forEach { $0?.isHidden = true }
    }
    
    private func setupRunningCycleState() {
        allLabels.forEach { $0?.isHidden = false }
        promptLabel?.isHidden = true
    }
    
    private func propertyAnimator(phase: BreathingPhaseViewModel) -> UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: phase.duration, curve: .linear) {
            if case .inhale = phase.type {
                self.breathingViewWidth?.constant = Constants.initialSquareWidth * 1.0
            } else if case .exhale = phase.type {
                self.breathingViewWidth?.constant = Constants.initialSquareWidth * 0.5
            }
            self.breathingView?.backgroundColor = phase.color
            self.view.layoutIfNeeded()
        }
        animator.addCompletion { _ in self.output?.onPhaseAnimationEnd(phase: phase) }
        return animator
    }
    
}
