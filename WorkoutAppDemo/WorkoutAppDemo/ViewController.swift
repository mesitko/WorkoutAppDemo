//
//  ViewController.swift
//  WorkoutAppDemo
//
//  Created by Michal Sitko on 12.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

//import Parse
//import Bolts
//import WorkoutDALParse

import UIKit
import ServiceLocatorDI
import WorkoutProtocols

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dalRepo = ServiceLocator.Get(PSportActivitiesRepository.self)
        dalRepo?.GetActiviies(NSDate(), endsAt: NSDate())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

