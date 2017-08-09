//
//  AppDelegate.swift
//  TestRecorder
//
//  Created by Emma Williams on 27/07/2017.
//  Copyright © 2017 Emma Williams. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Set AVAudioSession Category
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord,
                                    with: AVAudioSessionCategoryOptions.defaultToSpeaker)
            try session.setActive(true)
            
            // mic perms...
            session.requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    appHasMicAccess = true
                } else{
                    appHasMicAccess = false
                }
            })
            
        } catch let error as NSError {
            print("AVAudioSession configuration error: \(error.localizedDescription)")
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    
}



