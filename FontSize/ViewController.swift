//
//  ViewController.swift
//  FontSize
//
//  Created by KentarOu on 2016/06/04.
//  Copyright © 2016年 KentarOu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var baseViewHeightConstraint: NSLayoutConstraint!
    let animationDuration: NSTimeInterval = 1.5
    lazy var timerDuration: NSTimeInterval = {
        return 1 / self.fps
    }()
    
    let heightMin: CGFloat = 50
    let heightMax: CGFloat = 270
    let fps = 50.0
    var timer: NSTimer!
    
    
    // Animation
    @IBAction func pushAnimation(sender: UIButton) {
        baseViewHeightConstraint.constant = baseViewHeightConstraint.constant < heightMax ? heightMax : heightMin
        UIView.animateWithDuration(animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    // Slider
    @IBAction func changeSlider(sender: UISlider) {
        baseViewHeightConstraint.constant = CGFloat(sender.value)
    }
    
    // Timer
    @IBAction func pusuTimerSmall(sender: UIButton) {
        let distance: CGFloat = CGFloat(heightMax - heightMin) / (CGFloat(animationDuration) * CGFloat(fps))
        let targetHeight = baseViewHeightConstraint.constant < heightMax ? heightMax : heightMin
        timer = NSTimer.scheduledTimerWithTimeInterval(timerDuration, target: self, selector: #selector(ViewController.update(_:)), userInfo: ["targetHeight": targetHeight, "value": distance], repeats: true)
    }
    
    
    func update(timer: NSTimer) {
        if let targetHeight = timer.userInfo?["targetHeight"] as? CGFloat, let value = timer.userInfo?["value"] as? CGFloat {
            if targetHeight == heightMin {
                if baseViewHeightConstraint.constant > targetHeight {
                    baseViewHeightConstraint.constant -= value
                } else {
                    timer.invalidate()
                }
            } else {
                if baseViewHeightConstraint.constant < targetHeight {
                    baseViewHeightConstraint.constant += value
                } else {
                    timer.invalidate()
                }
                
            }
        }
    }
}
