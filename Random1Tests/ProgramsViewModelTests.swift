//
//  ProgramsViewModelTests.swift
//  Random1
//
//  Created by Joan Domingo on 11.07.17.
//
//

import XCTest
@testable import Random1
import RxSwift
import RxTest

class ProgramsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testInitialization() {
        //Initialize Programs View Model
        let programsViewModel = ProgramsViewModel()
        
        XCTAssertNotNil(programsViewModel, "The programs view model should be initialized")
        //XCTAssertNotNil(programsViewModel.programs, "The programs view model should be initialized")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}
