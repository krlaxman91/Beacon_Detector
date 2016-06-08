//
//  AppDelegate.swift
//  BeaconDetector
//
//  Created by Ashish on 08/06/16.
//  Copyright © 2016 Laxman. All rights reserved.
//

import UIKit
import CoreLocation




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , CLLocationManagerDelegate {
    
    var window: UIWindow?
    var locationManager: CLLocationManager!
    var lastProximity: CLProximity?
    
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        locationManagerSetup()
        beaconSetup()
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
    
    
    //MARK:- Internal Methods 
    
    func beaconSetup(){
        let uuidString = "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"
        let beaconIdentifier = "iBeaconModules.us"
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)!
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
                                                         identifier: beaconIdentifier)
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
        
    }
    
    func locationManagerSetup(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    
    func locationManager(manager: CLLocationManager,
                         didRangeBeacons beacons: [CLBeacon],
                                         inRegion region: CLBeaconRegion) {
        let viewController:ViewController = window!.rootViewController as! ViewController
        viewController.beacons = beacons as [CLBeacon]?
        viewController.tableView!.reloadData()
        
        NSLog("didRangeBeacons");
        
        
        if(beacons.count > 0) {
            let nearestBeacon:CLBeacon = beacons[0]
            
            if(nearestBeacon.proximity == lastProximity ||
                nearestBeacon.proximity == CLProximity.Unknown) {
                return;
            }
            lastProximity = nearestBeacon.proximity;
        } else {
            if(lastProximity == CLProximity.Unknown) {
                return;
            }
            lastProximity = CLProximity.Unknown
        }
    }
    
    func locationManager(manager: CLLocationManager,
                         didEnterRegion region: CLRegion) {
        manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        manager.startUpdatingLocation()
        
        NSLog("You entered the region")
    }
    
    func locationManager(manager: CLLocationManager,
                         didExitRegion region: CLRegion) {
        manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
        manager.stopUpdatingLocation()
        
        NSLog("You exited the region")
    }
    
    
    
}



