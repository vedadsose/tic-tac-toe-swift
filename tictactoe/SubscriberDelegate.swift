//
//  SubscriberDelegate.swift
//  tictactoe
//
//  Created by Vedad Sose on 11/06/16.
//  Copyright © 2016 seeout. All rights reserved.
//

import Foundation

protocol SubscriberDelegate {
  func update(state: GameState)
}