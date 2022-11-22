// DispatchQueue+Alamofire.swift
// Copyright © RoadMap. All rights reserved.

import Dispatch
import Foundation

extension DispatchQueue {
    static var userInteractive: DispatchQueue { DispatchQueue.global(qos: .userInteractive) }
    static var userInitiated: DispatchQueue { DispatchQueue.global(qos: .userInitiated) }
    static var utility: DispatchQueue { DispatchQueue.global(qos: .utility) }
    static var background: DispatchQueue { DispatchQueue.global(qos: .background) }

    func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
}
