//
//  UIFieldView.swift
//  Pods
//
//  Created by Vedad Sose on 09/06/16.
//
//

import UIKit

enum FieldState {
  case Empty
  case X
  case O
}

class UIFieldView: UIImageView {
  
  // Field's coordinates and it's value
  var x:Int
  var y:Int
  var state:FieldState
  var game: Game? = nil
  
  init(x: Int, y: Int, state: FieldState) {
    self.x = x
    self.y = y
    self.state = state
    super.init(frame: CGRect())
    
    // Set current image
    self.setImage()
    
    // Add click event handler
    let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(fieldClicked))
    self.userInteractionEnabled = true
    self.addGestureRecognizer(tapGestureRecognizer)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // Click event
  func fieldClicked() {
    guard let game = game else {
      fatalError("Game not defined")
    }
    
    state = game.move(x, y: y)
    self.setImage()
  }
  
  // Set image for field's state
  func setImage() {
    let imageName = state == .X ? "X" : "O"
    self.image = state != .Empty ? UIImage(named: imageName) : nil
  }
  
  
}
