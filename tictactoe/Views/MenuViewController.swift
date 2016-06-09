//
//  MenuViewController.swift
//  
//
//  Created by Vedad Sose on 06/06/16.
//
//

import UIKit
import Spring

class MenuViewController: UIViewController {
  
  // Outlets
  @IBOutlet weak var playButton: UIButton!
  
  override func viewDidAppear(animated: Bool) {
    playButton.addTarget(self, action: #selector(startGame), forControlEvents: .TouchUpInside)
  }

  func startGame() {
    print("idemo")
  }
  
}
