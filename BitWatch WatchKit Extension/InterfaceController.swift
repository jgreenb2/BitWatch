//
//  InterfaceController.swift
//  BitWatch WatchKit Extension
//
//  Created by jeff greenberg on 7/16/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import WatchKit
import Foundation
import BitWatchKit

class InterfaceController: WKInterfaceController {
    let tracker = Tracker()
    var updating = false

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        updatePrice(tracker.cachedPrice())
    }
    
    private func updatePrice(price: NSNumber) {
        priceLabel.setText(Tracker.priceFormatter.stringFromNumber(price))
    }
    
    private func update() {
        if !updating {
            updating = true
            let originalPrice = Tracker.cachedPrice(tracker)
            tracker.requestPrice{ (price, error) -> () in
                if error == nil {
                    self.updatePrice(price!)
                }
                self.updating = false
            }
        }
    }

    @IBOutlet weak var priceLabel: WKInterfaceLabel!
    @IBAction func refreshTapped() {
        update()
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        update()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
