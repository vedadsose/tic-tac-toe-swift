//
//  GameViewController.swift
//  tictactoe
//
//  Created by Vedad Sose on 09/06/16.
//  Copyright © 2016 seeout. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, SubscriberDelegate {
  
  // Outlets
  @IBOutlet weak var board: UIView!
  
  // Listening to the state
  func update(state: GameState) {
    print("Update ", state)
  }
  
  // Render the board
  override func viewDidLoad() {
    super.viewDidLoad()
        
    // Subscribe to app delegate
    game.subscribe(self)
    
    let fieldViews = generateFields(3, size: Int(board.frame.width/3))
    
    for fieldView in fieldViews {
      fieldView.game = game
      board.addSubview(fieldView)
    }
  }
  
  // Generate field views
  func generateFields(n: Int, size: Int) -> [UIFieldView] {
    var fieldViews = [UIFieldView]()
    
    var row = 0
    for i in 0 ..< n*n {
      let y = ((row+1)*3-i-1)
      let fieldView = UIFieldView(x: row, y: y, state: .Empty)
      fieldView.frame = CGRect(x: size*row, y: size*y, width: size, height: size)
      fieldViews.append(fieldView)
      
      // Increment row after we're done with one
      if((i+1) % 3 == 0) {
       row += 1
      }
    }
    
    return fieldViews
  }
  
}
