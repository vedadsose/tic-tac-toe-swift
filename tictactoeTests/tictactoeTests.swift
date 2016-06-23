//
//  tictactoeTests.swift
//  tictactoeTests
//
//  Created by Vedad Sose on 02/06/16.
//  Copyright © 2016 seeout. All rights reserved.
//

import XCTest
@testable import tictactoe

class tictactoeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWon() {
      XCTAssertTrue(won([[.X, .O, .O], [.X, .O, .X], [.X, .X, .O]]))
      XCTAssertFalse(won([[.X, .O, .X], [.X, .O, .X], [.O, .X, .O]]))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
