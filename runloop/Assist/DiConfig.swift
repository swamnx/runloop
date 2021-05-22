//
//  DiConfig.swift
//  runloop
//
//  Created by swamnx on 20.05.21.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    
    class func setup() {
        Container.loggingFunction = nil
        
        defaultContainer.register(FootballMatchService.self) { _ in DummyFootballMatchService()}.inObjectScope(.container)
        
        defaultContainer.storyboardInitCompleted(ViewController.self, initCompleted: { resolver, controller in
            controller.footballMatchService = resolver.resolve(FootballMatchService.self)!
        })
    }
}
