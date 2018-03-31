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
    
    private var output: BreathingViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "breathing_cycle", withExtension: "json")
        let provider = BreathingPhaseProvider(url: url)
        output = BreathingViewPresenter(provider: provider, view: self)
        output?.onViewLoad()
    }
    
}

