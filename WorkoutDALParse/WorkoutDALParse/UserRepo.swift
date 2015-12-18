//
//  UserRepo.swift
//  WorkoutDALParse
//
//  Created by Michal Sitko on 18.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation
import WorkoutProtocols

import Parse
import Bolts

public class UserRepo: PUserRepo{
    public func currentUser()->PUser?{
        let currentUser = PFUser.currentUser()
        if currentUser == nil{
            return nil
        }
        let file = currentUser!["profilePhoto"] as! PFFile
        let image = try! UIImage(data: file.getData())
        let user = User(userName: currentUser!.username!, photo: image)
        return user
    }
    
    public func logOut()->(){
        PFUser.logOut()
    }
    
    public func logIn( username: String, password : String) ->(){
        try! PFUser.logInWithUsername(username, password: password)
    }
    
    public init(){
        
    }
}