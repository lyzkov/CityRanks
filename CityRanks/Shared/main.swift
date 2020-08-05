//
//  main.swift
//  CityRanks
//
//  Created by lyzkov on 05/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil

let appDelegateClass = isRunningTests ? NSStringFromClass(FakeAppDelegate.self) : NSStringFromClass(AppDelegate.self)

let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    .bindMemory(
        to: UnsafeMutablePointer<Int8>?.self,
        capacity: Int(CommandLine.argc)
)

UIApplicationMain(CommandLine.argc, args, nil, appDelegateClass)
