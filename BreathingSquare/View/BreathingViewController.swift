//
//  BreathingViewController.swift
//  BreathingSquare
//
//  Created by Oleksii Huralnyk on 3/31/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import UIKit

class BreathingViewController: UIViewController, BreathingViewInput {
    
    @IBOutlet weak var breathingView: UIView?
    @IBOutlet weak var promptLabel: UILabel?
    @IBOutlet weak var phaseTypeLabel: UILabel?
    @IBOutlet weak var currentPhaseTimerLabel: UILabel?
    @IBOutlet weak var breathingCycleTimerLabel: UILabel?
    
    @IBOutlet weak var breathingViewWidth: NSLayoutConstraint?
    
    private var output: BreathingViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "breathing_cycle", withExtension: "json")
        let provider = BreathingPhaseProvider(url: url)
        output = BreathingViewPresenter(provider: provider, view: self)
        
        breathingView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapBreathingView)))
        
        output?.onViewLoad()
    }
    
    // MARK: - UI Actions
    
    @objc private func tapBreathingView(recognizer: UITapGestureRecognizer) {
        output?.onBreathingViewTap()
    }
    
    func setupInitialState() {
        promptLabel?.isHidden = false
        phaseTypeLabel?.isHidden = true
        currentPhaseTimerLabel?.isHidden = true
        breathingCycleTimerLabel?.isHidden = true
    }
    
    private func setupPreCycleState() {
        promptLabel?.isHidden = true
    }
    
    private func setupRunningCycleState() {
        promptLabel?.isHidden = true
        phaseTypeLabel?.isHidden = false
        currentPhaseTimerLabel?.isHidden = false
        breathingCycleTimerLabel?.isHidden = false
    }
    
    func startCycle(viewModels: [BreathingPhaseViewModel]) {
        setupPreCycleState()
        
        let initialWidth = self.breathingViewWidth?.constant ?? 0
        
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear) {
            self.breathingViewWidth?.constant = 0.75 * initialWidth
            self.view.layoutIfNeeded()
        }
        
        animator.addCompletion { (position) in
            if position == .end {
                self.setupRunningCycleState()
            }
        }
        
        animator.startAnimation()
    }
    
}

