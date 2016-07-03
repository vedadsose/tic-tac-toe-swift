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
  @IBOutlet weak var newGame: UIButton!
  @IBOutlet weak var findGame: UIButton!
  
  override func viewDidAppear(animated: Bool) {
    newGame.addTarget(self, action: #selector(startGame), forControlEvents: .TouchUpInside)
    findGame.addTarget(self, action: #selector(enterRoom), forControlEvents: .TouchUpInside)
  }

  // Open game view on start click
  func startGame() {
    self.performSegueWithIdentifier("GoToGame", sender: nil)
  }
  
  // Prompt the user to enter a room
  func enterRoom() {
    let alert = UIAlertController(title: "Join game", message: "Enter a room number", preferredStyle: .Alert)
    
    alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
      textField.text = ""
    })

    alert.addAction(UIAlertAction(title: "Join", style: .Default, handler: { (action) -> Void in
      let textField = alert.textFields![0] as UITextField
      let roomNumber = Int(textField.text!)
      self.performSegueWithIdentifier("GoToGame", sender: roomNumber)
    }))
    
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  // Catch segues and
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "GoToGame" {
      let gameViewController = segue.destinationViewController as! GameViewController

      // Initialize the game
      if let room = sender as? Int {
        gameViewController.game = Game(room: room, player: 1)
      } else {
        gameViewController.game = Game(player: 2)
      }
    }
  }
  
}
