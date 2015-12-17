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
    public func GetActiviies(startsAt: NSDate, endsAt: NSDate) -> ()/*-> [PSportActivity]*/{
        PFUser.logInWithUsernameInBackground("chuck.norris", password:"kick123") {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                var query = SportActivity.query()//PFQuery(className:"Cookie")
                //query!.limit = 1000
                query!.skip = 10
                var errPoint = NSErrorPointer()
                var countAll = query!.countObjects(errPoint)
                print("All: \(countAll)")
                query!.findObjectsInBackgroundWithBlock({
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        // The find succeeded.
                        print("Successfully retrieved \(objects!.count) scores.")
                        // Do something with the found objects
                        if let objects = objects {
                            for object in objects {
                                var act = object as! SportActivity
                                print("type: \(act.type), \(act.startsAt) - \(act.endsAt)")
                            }
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                    }
                )
            } else {
                // The login failed. Check error to see why.
                print("Error: \(error!) \(error!.userInfo)")
                
            }
        }
    }
    public init(){
        
    }
}