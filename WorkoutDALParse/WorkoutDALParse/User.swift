//
//  User.swift
//  WorkoutDALParse
//
//  Created by Michal Sitko on 18.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation
import WorkoutProtocols

import Parse
import Bolts

public class User : PUser{
    public var userName : String
    //public var password : String
    public var photo : UIImage?
    
    public init(userName: String,  photo : UIImage?){
        self.userName = userName
        self.photo = photo
    }
}