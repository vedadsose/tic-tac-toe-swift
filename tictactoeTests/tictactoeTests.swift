//
//  tictactoeTests.swift
//  tictactoeTests
//
//  Created by Vedad Sose on 02/06/16.
//  Copyright © 2016 seeout. All rights reserved.
//

import XCTest
import SwiftyJSON
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
      XCTAssertEqual(won([[.X, .O, .O], [.X, .O, .X], [.X, .X, .O]]), ["type" : "column", "column" : 1, "winner" : 1])
      XCTAssertEqual(won([[.X, .O, .X], [.O, .O, .O], [.O, .X, .X]]), ["type" : "row", "row" : 2, "winner" : 2])
      XCTAssertEqual(won([[.X, .O, .O], [.O, .X, .X], [.X, .O, .X]]), ["type" : "diagonal", "direction": "right", "winner" : 1])
      XCTAssertEqual(won([[.O, .O, .X], [.X, .X, .O], [.O, .X, .O]]), ["winner": 0])

      XCTAssertFalse(won([[.O, .O, .X], [.X, .X, .Empty], [.O, .X, .O]]))
  }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
