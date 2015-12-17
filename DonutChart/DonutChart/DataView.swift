//
//  DataView.swift
//  DonutChart
//
//  Created by Michal Sitko on 17.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation

public class DataView : UIView{
    
    //dictionary: activity - value, ex. runnint - 0.55 -> this means runnint 55%
    var data : [String: Double]?
    // colors for each activities
    var colors: [UIColor]?
    
    
    public override init(frame: CGRect){
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    // define data for chart
    public func defineDate(data : [String : Double], colors: [UIColor]){
        self.data = data
        self.colors = colors
    }
    
    

    
    
    }
