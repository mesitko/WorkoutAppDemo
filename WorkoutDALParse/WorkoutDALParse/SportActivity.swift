//
//  SportActivity.swift
//  WorkoutDALParse
//
//  Created by Michal Sitko on 15.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation
import WorkoutProtocols

import Parse
import Bolts

public class SportActivity : PFObject, PFSubclassing {
    public override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    public static func parseClassName() -> String {
        return "SportActivity"
    }
    
    @NSManaged public var type: String
    @NSManaged public var startsAt: NSDate
    @NSManaged public var endsAt: NSDate
}