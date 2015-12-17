//
//  DonutChart.swift
//  DonutChart
//
//  Created by Michal Sitko on 17.12.2015.
//  Copyright © 2015 Michal Sitko. All rights reserved.
//

import Foundation


public class DonutView : UIView{
    
    //dictionary: activity - value, ex. runnint - 0.55 -> this means runnint 55%
    var data : [String: Double]?
    // colors for each activities
    var colors: [UIColor]?
    
    var imageView : UIImageView?
    
    var userPhoto : UIImage?
    
    public override init(frame: CGRect){
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    // define data for chart
    public func defineDate(data : [String : Double], colors: [UIColor], userImage: UIImage){
        self.data = data
        self.colors = colors
        self.userPhoto = userImage
    }
    
    
    // animate chart
    public func animeteChart(duration: NSTimeInterval){
        
        let width = CGFloat( Float(frame.size.width) - 50.0)
        let height = CGFloat(Float(frame.size.height) - 50.0)
        self.imageView = UIImageView(frame: CGRect(x: 25.0, y: 25.0, width: width, height: height))
        self.imageView!.image = self.userPhoto
        self.imageView!.alpha = 0.0
        self.addSubview(self.imageView!)
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.imageView!.alpha = 1.0
            }, completion: nil)
        
        var progress = 0.0
        let cyrcleStart = (M_PI * 0.5)
        var step = 0
        
        for part in data!{
            let partLayer = CAShapeLayer()
            
            let startAngle = CGFloat( cyrcleStart + (M_PI * 2.0)*progress)
            let endAngle = startAngle + CGFloat((M_PI * 2.0) * part.1)
            
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: startAngle , endAngle: endAngle, clockwise: true)
            
            partLayer.path = circlePath.CGPath
            partLayer.fillColor = UIColor.clearColor().CGColor
            partLayer.strokeColor = colors![step].CGColor
            partLayer.lineWidth = 50.0;
            
            partLayer.strokeEnd = 0.0
            
            layer.addSublayer(partLayer)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            
            
            animation.duration = duration * part.1
            
            animation.fromValue = 0
            animation.toValue = 1
            animation.removedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            
            
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.beginTime = CACurrentMediaTime() + progress * duration
            print("part: \(part.0): \(part.1) begin time: \(CACurrentMediaTime() + progress * duration)")
            
            partLayer.addAnimation(animation, forKey: part.0)
            step++
            progress += part.1
        }
    }
    
    
    // rollback animation
    public func animateClear(duration: NSTimeInterval){
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.imageView!.alpha = 0.0
            }, completion: nil)
        
        let cyrcleStart = (M_PI * 2.5)
        let cyrcleEnd = (M_PI * 0.5)
        let partLayer = CAShapeLayer()
        
        let startAngle = CGFloat( cyrcleStart)
        let endAngle = CGFloat(cyrcleEnd)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: startAngle , endAngle: endAngle, clockwise: false)
        
        partLayer.path = circlePath.CGPath
        partLayer.fillColor = UIColor.clearColor().CGColor
        partLayer.strokeColor = UIColor.whiteColor().CGColor
        partLayer.lineWidth = 60.0;
        
        partLayer.strokeEnd = 0.0
        
        layer.addSublayer(partLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        
        animation.duration = duration
        
        animation.fromValue = 0
        animation.toValue = 1
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        partLayer.addAnimation(animation, forKey: "clear")
    }
}
