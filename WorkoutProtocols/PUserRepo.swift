//
//  PUserRepo.swift
//  WorkoutProtocols
//
//  Created by Michal Sitko on 18.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation

public protocol PUserRepo{
    func currentUser()->PUser?
    func logOut()->()
    func logIn( username: String, password : String) ->()
}