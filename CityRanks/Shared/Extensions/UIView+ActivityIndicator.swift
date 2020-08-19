//
//  UIView+ActivityIndicator.swift
//  CityRanks
//
//  Created by lyzkov on 19/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit

fileprivate var ActivityIndicatorViewAssociativeKey = "ActivityIndicatorViewAssociativeKey"

extension UIView {
    
   var activityIndicatorView: ActivityIndicatorView {
        get {
            if let activityIndicatorView = objc_getAssociatedObject(self, &ActivityIndicatorViewAssociativeKey) as? ActivityIndicatorView {
                return activityIndicatorView
            } else {
                let activityIndicatorView = ActivityIndicatorView()
                addSubview(activityIndicatorView)
                
                objc_setAssociatedObject(self, &ActivityIndicatorViewAssociativeKey, activityIndicatorView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return activityIndicatorView
            }
        }

        set {
            addSubview(newValue)
            objc_setAssociatedObject(self, &ActivityIndicatorViewAssociativeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
