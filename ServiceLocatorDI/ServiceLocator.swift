//
//  ServiceLocator.swift
//  ServiceLocatorDI
//
//  Created by Michal Sitko on 15.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation

public class ServiceLocatorItem<T>{
    public var slProtocol : T.Type
    public var slFactory : ()->T
    public init(  _ factory:()->T ){
        self.slFactory = factory
        self.slProtocol = T.self
    }
}

public class ServiceLocator{
    
    public static var WellKnownTypes = [Any]()
    
    public static func Register<T>( factory: ()->T ) -> (){
        let item = ServiceLocatorItem<T>( factory)
        ServiceLocator.WellKnownTypes.append(item)
    }
    public static func Get<T>(type : T.Type) -> T?{
        
        var results = ServiceLocator.WellKnownTypes.filter( {(item: Any) -> Bool in return item is ServiceLocatorItem<T>})
        if results.count > 0{
            let result : ServiceLocatorItem<T> = results[0] as! ServiceLocatorItem<T>
            let obj = result.slFactory()
            return obj
        }
        else{
            return nil
        }
    }
}