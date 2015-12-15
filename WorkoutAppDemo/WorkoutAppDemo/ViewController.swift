//
//  ViewController.swift
//  WorkoutAppDemo
//
//  Created by Michal Sitko on 12.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Parse
import Bolts
import WorkoutDALParse

import UIKit
import ServiceLocatorDI
import WorkoutProtocols

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let dalRepo = ServiceLocator.Get(PSportActivitiesRepository.self)
        //dalRepo?.GetActiviies(NSDate(), endsAt: NSDate())
        PFUser.logInWithUsernameInBackground("chuck.norris", password:"kick123") {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                var query = SportActivity.query()//PFQuery(className:"Cookie")
                query!.limit = 10
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

