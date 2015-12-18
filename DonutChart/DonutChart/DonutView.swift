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
        
        let width = frame.size.width - 10
        let height = frame.size.width - 10
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
            
            //let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.width / 2.0), radius: (frame.size.width - 10)/2, startAngle: startAngle , endAngle: endAngle, clockwise: true)
            let radius = (frame.size.width - 10)/2
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: 25+radius, y: 25+radius), radius: radius, startAngle: startAngle , endAngle: endAngle, clockwise: true)
            
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
            print("part: \(part.0): \(String(format: "%.2f", part.1*100)) begin time: \(CACurrentMediaTime() + progress * duration)")
            
            let label = UILabel()
            label.text = "\(String(format: "%.2f", part.1*100))% \(part.0)"
            label.frame = CGRect(x:30, y:300+20*step, width:350, height: 20)
            label.textColor = colors![step]
            label.alpha = 0
            self.addSubview(label)
            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                label.alpha = 1.0
                }, completion: nil)

            
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
        
        let radius = (frame.size.width - 10)/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 25+radius, y: 25+radius), radius: (frame.size.width - 10)/2, startAngle: startAngle , endAngle: endAngle, clockwise: false)
        
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
