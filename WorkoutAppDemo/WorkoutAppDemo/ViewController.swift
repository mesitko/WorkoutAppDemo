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
import DonutChart
import GeneralExtensions

import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate {
    // variables
    var donutView : DonutView?
    var logInController : PFLogInViewController?

    
    // outlets
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var userLabel : UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var dateFromPicker : UIDatePicker!
    @IBOutlet weak var dateToPicker : UIDatePicker!
    @IBOutlet weak var progressView : UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.alpha = 0.0
        segment.addTarget(self, action: "segmentedControlValueChanged:", forControlEvents:.TouchUpInside)
        //let dalRepo = ServiceLocator.Get(PSportActivitiesRepository.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        setUserState()
    }
    
    /// prepare donut chart
    func prepareDonut(activities: [PSportActivity]){
        if donutView != nil{
            donutView?.removeFromSuperview()
            donutView = nil
        }
        donutView = DonutView(frame:CGRect(x:50, y:300, width:250, height: 550))
        self.view.addSubview(donutView!)
        
        let data = DataCreator.PrepareData(activities)
        let colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.yellowColor(), UIColor.purpleColor(), UIColor.brownColor(), UIColor.orangeColor(), UIColor.grayColor()]
        
        
        
        let userRepo = ServiceLocator.Get(PUserRepo.self)
        let user = userRepo?.currentUser()
        
        self.donutView!.defineDate( data, colors: colors, userImage: user!.photo!)
        self.donutView!.animeteChart(3)
    }
    
    func datePickersState(){
        if( segment.selectedSegmentIndex == 0){
            dateFromPicker.hidden = false;
            dateToPicker.hidden = true;
        }
        else{
            dateFromPicker.hidden = true;
            dateToPicker.hidden = false
        }
    }

    
    func setUserState(){
        
        let userRepo = ServiceLocator.Get(PUserRepo.self)
        let user = userRepo?.currentUser()
        if user != nil{
            userLabel.text = user?.userName
            logoutBtn.hidden = false
            searchBtn.hidden = false
            dateToPicker.hidden = segment.selectedSegmentIndex != 1
            dateFromPicker.hidden = segment.selectedSegmentIndex != 0
            segment.hidden = false
        }
        else{
            userLabel.text = ""
            logoutBtn.hidden = true;
            searchBtn.hidden = true
            dateToPicker.hidden = true
            dateFromPicker.hidden = true
            segment.hidden = true
            
            if( logInController == nil){
                logInController = PFLogInViewController()
                logInController!.fields = .UsernameAndPassword
                logInController!.delegate = self
            }
            self.presentViewController(logInController!, animated:true, completion: nil)
        }
    }
    
    func logInViewController(controller: PFLogInViewController, didLogInUser user: PFUser!) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
        if user != nil{
            print("Logged in")
        }
        else{
            print("Cannot login")
        }
        setUserState()
    }
    
    func logInViewControllerDidCancelLogIn(controller: PFLogInViewController) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("login cancelled")
    }
    
    @IBAction func logOut(sender: UIButton) {
        let userRepo = ServiceLocator.Get(PUserRepo.self)
        let user = userRepo?.currentUser()
        if( user != nil){
            userRepo?.logOut()
            donutView?.animateClear(3)
            donutView?.removeFromSuperview()
            donutView = nil
        }
        setUserState()
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        //print("changed")
        datePickersState()
    }
    
    @IBAction func search(sender: UIButton) {
        performSearch()
    }
    
    func performSearch()->(){
        if donutView != nil{
            donutView!.animateClear(1)
        }
        
        self.transformToProgress()
        
        let repo = ServiceLocator.Get(PSportActivitiesRepository.self)
        var sumProgress = Float(0.0)
        
        repo!.Get(dateFromPicker.date, dateToPicker.date, {(f: Float) -> () in sumProgress += f
            self.progressView.progress = sumProgress},  {(results: [PSportActivity] )-> () in
                self.transformToDone()
                self.prepareDonut(results)
            },
            {(error: NSError?)->() in
                print("error during getting data")
                self.transformToDone()
        })
    }
    
    
    func transformToProgress(){
        self.progressView.progress = 0
        UIView.animateWithDuration(2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.searchBtn.alpha = 0
            self.segment.alpha = 0
            self.dateFromPicker.alpha = 0
            self.dateToPicker.alpha = 0
            self.logoutBtn.alpha = 0
            self.userLabel.alpha = 0
            }, completion: nil)
        
        UIView.animateWithDuration(2, delay: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.progressView.alpha = 1.0
            }, completion: nil)
    }
    
    func transformToDone(){

        self.progressView.progress = 1
        UIView.animateWithDuration(2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.progressView.alpha = 0.0
            }, completion: nil)
        
        UIView.animateWithDuration(2, delay: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.searchBtn.alpha = 1
            self.segment.alpha = 1
            self.dateFromPicker.alpha = 1
            self.dateToPicker.alpha = 1
            self.logoutBtn.alpha = 1
            self.userLabel.alpha = 1
            }, completion: nil)
    }

}


















