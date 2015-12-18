//
//  SportActivitiesRepository.swift
//  WorkoutDALParse
//
//  Created by Michal Sitko on 15.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation
import WorkoutProtocols

import Parse
import Bolts




public  class SportActivitiesRepository: PSportActivitiesRepository{
    public func Get( dateFrom: NSDate, _ dateTo: NSDate, _ progresTick: RepoTickProgressBlock, _ repoDone : RepoAllDone, _ error : ErrorBlock){
        var activities = [PSportActivity]()
        
        let query = SportActivity.query()
        query?.whereKey("startsAt", greaterThanOrEqualTo: dateFrom)
        query?.whereKey("endsAt", lessThanOrEqualTo: dateTo)
        query!.countObjectsInBackgroundWithBlock({
            (count: Int32, error: NSError?) -> Void in
            if error == nil{
                print("total number: \(count)")
                if count == 0{
                    let results = [PSportActivity]()
                    repoDone(results)
                }
                var steps = count / 10
                if count % 10 > 0{
                    steps = steps + 1
                }
                var stepsReady = 0
                for var step=Int32(0); step<steps; ++step{
                    let query = SportActivity.query()
                    query?.whereKey("startsAt", greaterThanOrEqualTo: dateFrom)
                    query?.whereKey("endsAt", lessThanOrEqualTo: dateTo)
                    query!.skip = 10*Int(step)
                    query!.limit = 10
                    query!.findObjectsInBackgroundWithBlock({
                        (objects: [PFObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            
                            // The find succeeded.
                            print("Successfully retrieved \(objects!.count) scores.")
                            // Do something with the found objects
                            if let objects = objects {
                                for object in objects {
                                    let act = object as! SportActivity
                                    activities.append(act)
                                    //print("type: \(act.type), \(act.startsAt) - \(act.endsAt)")
                                }
                            }
                            progresTick(10.0/Float(count))
                            stepsReady++;
                            if( stepsReady == Int(steps)){
                                repoDone(activities)
                            }
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                        }
                    )
                }
            }
            else{
                print(error)
                
            }
        })
        
    }

    
    
    
    public init(){
        
    }
    
    
    
}