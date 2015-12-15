//
//  PDALModule.swift
//  WorkoutProtocols
//
//  Created by Michal Sitko on 15.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation

public protocol PDALModule{
    func SetUp()->()
    func LogIn(user: PUser) -> PUser
    func LogOut()->()
}