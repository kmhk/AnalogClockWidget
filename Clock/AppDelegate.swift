//
//  AppDelegate.swift
//  Clock
//
//  Created by com on 11.12.23..
//

import Foundation
import UIKit
import BackgroundTasks
import WidgetKit
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("app launching")
        
        //AppDelegate.initAppRefresh()
        
        return true
    }
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
        return config
    }
    
    
    static func initAppRefresh() {
        print("app background refreshing is initializing now..")
        let re = BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.clock.widget.refresh", using: DispatchQueue.global()) { task in
            AppDelegate.handelAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        print("result: \(re)")
    }
    
    
    static func scheduleAppRefresh() {
        BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: "com.clock.widget.refresh")
        
        //let request = BGProcessingTaskRequest(identifier: "com.clock.widget.refresh")
        let request = BGAppRefreshTaskRequest(identifier: "com.clock.widget.refresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 5 * 60)
        
        do {
            try BGTaskScheduler.shared.submit(request)
            print("break")
        } catch {
            print( "BGTaskScheduler.shared.submit \(error.localizedDescription)")
        }
        
        print("background task submitted successfully")
    }
    
    
    static func handelAppRefresh(task: BGAppRefreshTask) {
        print("app refreshed in background!")
        
        AudioServicesPlaySystemSound(1016)
        
        WidgetCenter.shared.reloadAllTimelines()
        
        scheduleAppRefresh()
        
        task.setTaskCompleted(success: true)
    }
    
}



class SceneDelegate: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("scene did enter background")
        //AppDelegate.scheduleAppRefresh()
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print("scene disconnect")
    }
}
