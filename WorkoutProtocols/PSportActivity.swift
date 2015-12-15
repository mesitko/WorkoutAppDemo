//
//  PSportActivity.swift
//  WorkoutProtocols
//
//  Created by Michal Sitko on 15.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation


public protocol PSportActivity{
    var startsAt : NSDate {get set}
    var endsAt : NSDate {get set}
    var type : String {get set}
}