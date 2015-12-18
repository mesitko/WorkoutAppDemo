//
//  DataCreator.swift
//  WorkoutAppDemo
//
//  Created by Michal Sitko on 18.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation
import WorkoutProtocols

///Class for generting charting data
class DataCreator{
    static func PrepareData(activities : [PSportActivity])->[String:Double]{
        var dict = [String:Double]()
        if activities.count == 0{
            dict["none"] = 1
            return dict
        }
        
        var sum = 0.0
        for activity in activities{
            let valueToAdd = activity.endsAt.MinutesFrom(activity.startsAt)
            sum += valueToAdd
            if dict[activity.type] != nil{
                dict[activity.type] = dict[activity.type]! + valueToAdd
            }
            else{
                dict[activity.type] = valueToAdd
            }
        }
        for item in dict{
            dict[item.0] = dict[item.0]! / sum
        }
        return dict
    }
}