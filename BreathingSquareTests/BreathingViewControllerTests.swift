//
//  BreathingViewControllerTests.swift
//  BreathingSquareTests
//
//  Created by Oleksii Huralnyk on 3/31/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import XCTest
@testable import BreathingSquare

class BreathingViewControllerTests: XCTestCase {
    
    var sut: BreathingViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        sut = storyboard.instantiateViewController(withIdentifier: "BreathingViewController") as! BreathingViewController
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testViewDidLoad_OutletsShouldBeConnected() {
        // when
        _ = sut.view
        
        // then
        XCTAssertNotNil(sut.breathingView)
        XCTAssertNotNil(sut.promptLabel)
        XCTAssertNotNil(sut.phaseTitleLabel)
        XCTAssertNotNil(sut.phaseTimerLabel)
        XCTAssertNotNil(sut.cycleTimerTitleLabel)
        XCTAssertNotNil(sut.cycleTimerLabel)
    }
    
}
