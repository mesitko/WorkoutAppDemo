//
//  PSportActivitiesRepository.swift
//  WorkoutProtocols
//
//  Created by Michal Sitko on 15.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation


public typealias RepoTickProgressBlock = (Float)->Void
public typealias RepoAllDone = ([PSportActivity]) -> Void
public typealias ErrorBlock = (NSError?) -> Void

public protocol PSportActivitiesRepository{
    func Get( dateFrom: NSDate, _ dateTo: NSDate, _ progresTick: RepoTickProgressBlock, _ repoDone : RepoAllDone, _ error : ErrorBlock)
}