//
//  UIFieldView.swift
//  Pods
//
//  Created by Vedad Sose on 09/06/16.
//
//

import UIKit
import SwiftyJSON

enum FieldState:String {
  case Empty = ""
  case X = "X"
  case O = "O"
}

class UIFieldView: UIView {
  
  // Field's coordinates and it's value
  var x:Int
  var y:Int
  var state:FieldState
  var game: Game? = nil
  
  var imageView: UIImageView?
  
  init(x: Int, y: Int, state: FieldState, frame: CGRect) {
    self.x = x
    self.y = y
    self.state = state
    super.init(frame: frame)
    
    // Set current image
    self.setImage()
    
    // Add click event handler
    let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(fieldClicked))
    self.userInteractionEnabled = true
    self.addGestureRecognizer(tapGestureRecognizer)
   
    // Initialize UILabel for presenting X and O
    imageView = UIImageView(frame: CGRect(x: frame.size.width/2-20, y: frame.size.height/2-20, width: 40, height: 40))
    
    self.addSubview(imageView!)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // Click event
  func fieldClicked() {
    guard let game = game else {
      fatalError("Game not defined")
    }
    
    game.dispatch(["type": "MOVE", "x": x, "y": y, "player": game.player])
    self.setImage()
  }
  
  // Set image for field's state
  func setImage() {
    if let imageView = imageView {
      if self.state == .Empty {
        imageView.image = UIImage()
      } else {
        let imageName = self.state == .X ? "X" : "O"
        imageView.image = UIImage(named: imageName)
      }
    }
  }
  
  
}
