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

  // Open game view on start click
  func startGame() {
    self.performSegueWithIdentifier("GoToGame", sender: self)
  }
  
}
