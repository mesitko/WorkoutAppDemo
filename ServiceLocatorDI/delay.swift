//
//  delay.swift
//  ServiceLocatorDI
//
//  Created by Michal Sitko on 17.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation

public func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
