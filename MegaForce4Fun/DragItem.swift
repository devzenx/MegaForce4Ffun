//
//  DragItem.swift
//  MegaForce4Fun
//
//  Created by Stéphane DEPOILLY on 18/04/2016.
//  Copyright © 2016 Stéphane DEPOILLY. All rights reserved.
//

import Foundation
import UIKit

class DragItem: UIImageView {
    
    var originalPosition: CGPoint!
    var dropTarget: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // as soon as this class is initialized, we play the animation.
        
    }
    
    //// Everytime the user touches the screen
    //// Record the center position of the item so if it is not a good drag, it goes back to its original position.
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center //(vertical/horizontal center of the image)
        
    }
    //// When you touch, hold & move
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // touches.first = the first object touched in the "touches set"
        if let touch = touches.first {
            let position = touch.locationInView(self.superview) // We grab the position in the view that contains all images
            self.center = CGPointMake(position.x, position.y)
        }
    }
    //// When you move your finger off the screen.
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first, let target = dropTarget {
            let position = touch.locationInView(self.superview)
            // If the position you tapped on inside the target frame, then we passe it to the touch = position
            if CGRectContainsPoint(target.frame, position) {
                
                dropTarget!.tag = self.tag // Transfer the self.image tag to the droptarget
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
            }
        }
        
        self.center = originalPosition // It goes back to the position when the user first touched it if it's not on the target
    }

}
    