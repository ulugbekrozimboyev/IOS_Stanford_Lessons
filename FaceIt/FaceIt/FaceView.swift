//
//  FaceView.swift
//  FaceIt
//
//  Created by Ulugbek on 3/4/17.
//  Copyright © 2017 Ulugbek. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    var scale: CGFloat = 0.90
    
    var skullRadius : CGFloat {
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthwidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
        
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCircleCenteredAtPoint(midPoint:CGPoint, withRadius:CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: midPoint, radius: withRadius, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: false)
        path.lineWidth = 5.0
        return path
        
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
            case .Left: eyeCenter.x -= eyeOffset
            case .Right: eyeCenter.x += eyeOffset
        }
        
        return eyeCenter
    }
    
    private func pathForEye(eye:Eye) -> UIBezierPath{
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye: eye)
        
        return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
    }

    private func pathForMouth() -> UIBezierPath {
        
        let mouthWith = skullRadius / Ratios.SkullRadiusToMouthwidth
        let moutHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWith/2, y: skullCenter.y + mouthOffset, width: mouthWith, height: moutHeight)
        
//        return UIBezierPath(rect: mouthRect)
        let mouthCurvature:Double = 1.0
        let smileOffset = CGFloat(max(-1, min(mouthCurvature,1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width/3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width/3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 5.0
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        
        UIColor.blue.set()
        pathForCircleCenteredAtPoint(midPoint: skullCenter, withRadius: skullRadius).stroke()
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
        pathForMouth().stroke()
    }
    

}
