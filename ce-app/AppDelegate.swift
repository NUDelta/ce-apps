//
//  AppDelegate.swift
//  ce-app
//
//  Created by Kevin Chen on 2/5/16.
//  Copyright © 2016 delta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let endpoint = "ws://localhost:3000/websocket"
    let version = "1"

    var window: UIWindow?
    var meteorClient: MeteorClient!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        meteorClient = MeteorClient.init(DDPVersion: version)
        let ddp = ObjectiveDDP.init(URLString: endpoint, delegate: meteorClient)
        meteorClient.ddp = ddp
        meteorClient.ddp.connectWebSocket()
        return true
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        let query = url.parseQuery()
        
        // TESTING: paste 'ceapp://?action=participate&id=[find a expId' into Safari
        if let action = query["action"] as? String, experienceId = query["id"] as? String {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            switch (action) {
            case "participate":
                let participateController = storyboard.instantiateViewControllerWithIdentifier("participateController") as! ParticipateController
                participateController.expId = experienceId
                self.window?.rootViewController?.presentViewController(participateController, animated: true, completion: nil)
                break
            default:
                break
            }
        }
        return true
    }
}

