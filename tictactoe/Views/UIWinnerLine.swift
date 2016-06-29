//
//  UIWinnerLine.swift
//  tictactoe
//
//  Created by Vedad Sose on 24/06/16.
//  Copyright © 2016 seeout. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class UIWinnerLine: UIView {
  
  init(info: JSON, size: CGFloat, spacing: Int = 20, thickness: Int = 10) {
    let fieldSize = Int(size / 3)
    let startingPoint = Int(size / -6)
    
    switch info["type"].stringValue {
      case "row":
        let x = spacing
        let y = startingPoint + info["row"].intValue * fieldSize - thickness/2
        let width = Int(size) - spacing*2
        let height = thickness
        super.init(frame: CGRect(x: x, y: y, width: 0, height: height))
        
        UIView.animateWithDuration(0.3, animations: {
          var newFrame = self.frame
          newFrame.size = CGSizeMake(CGFloat(width), CGFloat(height))
          self.frame = newFrame
        })
        break
      case "column":
        let x = startingPoint + info["column"].intValue * fieldSize - thickness/2
        let y = spacing
        let width = thickness
        let height = Int(size) - spacing*2
        
        super.init(frame: CGRect(x: x, y: y, width: width, height: 0))
        
        UIView.animateWithDuration(0.3, animations: {
          var newFrame = self.frame
          newFrame.size = CGSizeMake(CGFloat(width), CGFloat(height))
          self.frame = newFrame
        })
        break
      case "diagonal":
        let width = CGFloat(thickness) / sqrt(2);
        let height = sqrt(2*size*size) / sqrt(2);
        let x = 0
        let y = 0
        
        super.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        self.bounds = CGRectMake( 0, 0, width, height );

        UIView.animateWithDuration(0.3, animations: {
//          var newFrame = self.frame
//          newFrame.size = CGSizeMake(CGFloat(width), CGFloat(height))
//          self.frame = newFrame
          self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))

        })
        break
      default:
        super.init()
    }
    
    self.backgroundColor = UIColor.whiteColor()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}