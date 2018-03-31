//
//  BreathingPhaseProviderTests.swift
//  BreathingSquareTests
//
//  Created by Oleksii Huralnyk on 3/31/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import XCTest
@testable import BreathingSquare

class BreathingPhaseProviderTests: XCTestCase {
    
    lazy var validFileURL: URL? = Bundle(for: type(of: self)).url(forResource: "valid_cycle", withExtension: "json")
    
    func testFetchPhases_FromNotExistingFile_ReturnsEmptyArray() {
        // given
        let sut = BreathingPhaseProvider(url: URL(string: "foo"))
        
        // when
        let results = sut.fetchPhases()
        
        // then
        XCTAssertEqual(results.count, 0)
    }
    
    func testFetchPhases_FromValidFile_ReturnsExpectedNumberOfPhases() {
        // given
        let sut = BreathingPhaseProvider(url: validFileURL)
        
        // when
        let results = sut.fetchPhases()
        
        // then
        XCTAssertEqual(results.count, 6)
    }
    
    func testFetchPhases_FromValidFile_FirstPhase_IsValid() {
        // given
        let sut = BreathingPhaseProvider(url: validFileURL)
        
        // when
        let first = sut.fetchPhases().first
        
        // then
        XCTAssertEqual(first?.type, "inhale")
        XCTAssertEqual(first?.duration, 4)
        XCTAssertEqual(first?.color, "#FF00FF")
    }
    
    func testFetchPhases_FromValidFile_LastPhase_IsValid() {
        // given
        let sut = BreathingPhaseProvider(url: validFileURL)
        
        // when
        let first = sut.fetchPhases().last
        
        // then
        XCTAssertEqual(first?.type, "hold")
        XCTAssertEqual(first?.duration, 8)
        XCTAssertEqual(first?.color, "#FFFFFF")
    }
    
}
