//
//  UIView-Additions.swift
//  Culiacan
//
//  Created by Diego Mendoza on 31/05/15.
//  Copyright (c) 2015 godi. All rights reserved.
//

import Foundation
import UIKit


let KANIMATION_DURATION = 0.35


extension UIView {
    
    
    func startLoading(title: String) {
        let w = self.frame.size.width
        let h = self.frame.size.height
        
        let loadingView = LoadingView(frame: CGRectMake(w / 2 - 75, h / 2 - 75, 150, 150))
        loadingView.title = title
        
        addSubview(loadingView)
        userInteractionEnabled = false
    }
    
    func stopLoading() {
        for v in subviews {
            if v.isKindOfClass(LoadingView){
                v.removeFromSuperview()
            }
            }
    
        userInteractionEnabled = true
    }
    
    func presentViewFromBottom(view: UIView, animated: Bool) {
        if(animated){
            view.frame = CGRectMake(0, self.bounds.size.height, view.bounds.size.width, view.bounds.size.height)
            self.addSubview(view)
            UIView.animateWithDuration(KANIMATION_DURATION, animations: {
                view.frame = CGRectMake(0, self.bounds.size.height - view.bounds.size.height, view.bounds.size.width, view.bounds.size.height)
            })
        }else{
            view.frame = CGRectMake(0, self.bounds.size.height - view.bounds.size.height, view.bounds.size.width, view.bounds.size.height)
            self.addSubview(view)
        }
        
    }
    
    func dismissViewFromBottom(view: UIView, animated: Bool) {
        if animated {
            UIView.animateWithDuration(KANIMATION_DURATION, animations: {
                view.frame = CGRectMake(0, self.bounds.size.height, view.bounds.size.width, view.bounds.size.height)
                }, completion: { finished in
                    view.removeFromSuperview()
            })
        }else{
            view.removeFromSuperview()
        }
        
    }
    
    func removeSingleConstraint(constraint: NSLayoutConstraint) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        for c in self.constraints {
            if (c ) != constraint {
                constraints.append(c )
            }
        }
        self.removeConstraints(self.constraints)
        return constraints
    }
    
}