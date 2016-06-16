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
  
  // Game
  var game: Game? = nil
  
  // Listening to the state
  func update(state: GameState) {
    print("Update ", state)
    
    board.subviews.forEach({ field in
      if let field = field as? UIFieldView {
        field.state = state.board[field.x][field.y]
        field.setImage()
      }
    })
  }
  
  // Render the board
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let game = game else {
      print("Game not initialized")
      return
    }
    
    // Subscribe to app delegate
    game.subscribe(self)
    
    // Generate fields
    let fieldViews = generateFields(3, size: Int(board.frame.width/3))
    
    for fieldView in fieldViews {
      fieldView.game = game
      board.addSubview(fieldView)
    }
    
    // Generate lines between fields
    let line1 = UIView(frame: CGRect(x: Int(board.frame.width/3), y: 0, width: 1, height: Int(board.frame.height)))
    line1.backgroundColor = UIColor.whiteColor()
    board.addSubview(line1)
    
    let line2 = UIView(frame: CGRect(x: Int(board.frame.width/3)*2, y: 0, width: 1, height: Int(board.frame.height)))
    line2.backgroundColor = UIColor.whiteColor()
    board.addSubview(line2)
    
    let line3 = UIView(frame: CGRect(x: 0, y: Int(board.frame.height/3), width: Int(board.frame.width), height: 1))
    line3.backgroundColor = UIColor.whiteColor()
    board.addSubview(line3)
    
    let line4 = UIView(frame: CGRect(x: 0, y: Int(board.frame.height/3)*2, width: Int(board.frame.width), height: 1))
    line4.backgroundColor = UIColor.whiteColor()
    board.addSubview(line4)
  }
  
  // Generate field views
  func generateFields(n: Int, size: Int) -> [UIFieldView] {
    var fieldViews = [UIFieldView]()

    for i in 0 ..< n {
      for n in 0 ..< n {
        let fieldView = UIFieldView(x: i, y: n, state: .Empty, frame: CGRect(x: size*n, y: size*i, width: size, height: size))
        fieldViews.append(fieldView)
      }
    }
    
    return fieldViews
  }
  
}
