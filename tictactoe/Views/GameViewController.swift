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
    
    board.subviews.forEach({ field in
      if let field = field as? UIFieldView {
        field.state = state.board[field.y][field.x]
        print("update state", state.board[field.y][field.x])
        field.setImage()
      }
    })
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

    for i in 0 ..< n {
      for n in 0 ..< n {
        let fieldView = UIFieldView(x: n, y: i, state: .Empty)
        fieldView.frame = CGRect(x: size*n, y: size*i, width: size, height: size)
        fieldViews.append(fieldView)
      }
    }
    
    return fieldViews
  }
  
}
