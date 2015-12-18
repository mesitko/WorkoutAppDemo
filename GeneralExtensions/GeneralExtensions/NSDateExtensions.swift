//
//  NSDateExtensions.swift
//  GeneralExtensions
//
//  Created by Michal Sitko on 18.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation

extension NSDate{
    public func MinutesFrom( date : NSDate) -> Double{
        var dif = self.timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate
        if dif < 0{
            dif = dif * (-1)
        }
        return dif/60
    }
}