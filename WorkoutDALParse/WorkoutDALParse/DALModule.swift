//
//  DALModule.swift
//  WorkoutDALParse
//
//  Created by Michal Sitko on 15.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation
import WorkoutProtocols

import Parse
import Bolts

public class DALModule : PDALModule{
    public func SetUp()->(){
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("7gwmIKcCH00O9C21u1rEhwvnihsZkflY24rD1PEH",
            clientKey: "d4INr8zQ9ICM3jaViDrCHXv2i7smrxE6sTKslRE9")
    }
    /*
    public func LogIn(user: PUser) -> PUser{
        
    }
    */
    public func LogOut()->(){
        
    }
    
    public init(){
        
    }
    
    public func CurrentUser()->(PUser?){
        var currentUser = PFUser.currentUser()
        if currentUser == nil{
            return nil
        }
        var file = currentUser!["profilePhoto"] as! PFFile
        let image = try! UIImage(data: file.getData())
        var user = User(userName: currentUser!.username!, photo: image)
        return user
    }
}







