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
import DonutChart

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dalRepo = ServiceLocator.Get(PSportActivitiesRepository.self)
        //dalRepo?.GetActiviies(NSDate(), endsAt: NSDate())
        
        let chartView = DonutView(frame: CGRect(x:50.0, y:50.0, width: 250.0, height: 250.0))
        self.view.addSubview(chartView)
        //chartView.animateCircle(10)
        
        let data = ["running": 0.5, "karate":0.3, "swimming" : 0.2]
        let colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.blackColor(), UIColor.yellowColor()]
        
        chartView.defineDate( data, colors: colors)
        chartView.animeteChart(3)
        
        delay(6){
            print("it is time!")
            chartView.animateClear(3)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}






