//
//  UIButton+Closure.swift
//  CityRanks
//
//  Created by lyzkov on 18/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func add(action: @escaping () -> Void, for controlEvents: UIControl.Event = .touchUpInside) {
        actionHandler(action: action)
        addTarget(self, action: #selector(triggerActionHandler), for: controlEvents)
    }
    
    @objc private func triggerActionHandler() {
        actionHandler()
    }
    
    private func actionHandler(action:(() -> Void)? = nil) {
        struct __ {
            static var action :(() -> Void)?
        }
        if action != nil {
            __.action = action
        } else {
            __.action?()
        }
    }
    
}
