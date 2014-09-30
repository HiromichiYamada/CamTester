//
//  AppDelegate.swift
//  CamTester
//
//  Created by 山田宏道 on 2014/09/29.
//  Copyright (c) 2014年 Torques Inc. All rights reserved.
//

import UIKit
import Darwin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	// println(getSysctl("hw.machine"))
	func getSysctl(name:String) -> String? {
		return name.withCString {
			(cName:UnsafePointer<CChar>)->String? in
			var size: UInt = 0 //size_tの代わりにUInt
			if sysctlbyname(cName, nil, &size, nil, 0) != 0 {
				perror(cName)
				return nil
			}
			var value = [CChar](count: Int(size) / sizeof(CChar), repeatedValue: 0)
			sysctlbyname(cName, &value, &size, nil, 0)
			var retString : NSString = NSString(bytes: value, length: Int(size), encoding: NSUTF8StringEncoding)
			return retString.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString:"\0")) as String
		}
	}
	
	func hardwareName() -> String {
		let strHWMachine : String?	= self.getSysctl("hw.machine")
		if( strHWMachine != nil ){
			switch( strHWMachine! ){
			case "iPhone1,1":	return "iPhone 1G"
			case "iPhone1,2":	return "iPhone 3G"
			case "iPhone2,1":	return "iPhone 3GS"
			case "iPhone3,1":	return "iPhone 4 (GSM)"
			case "iPhone3,2":	return "iPhone 4 (Other Carrier)"
			case "iPhone3,3":	return "iPhone 4 (CDMA)"
			case "iPhone4,1":	return "iPhone 4S"
			case "iPhone5,1":	return "iPhone 5 (GSM)"
			case "iPhone5,2":	return "iPhone 5 (GSM+CDMA)"
			case "iPhone5,3":	return "iPhone 5c (GSM)"
			case "iPhone5,4":	return "iPhone 5c (GSM+CDMA)"
			case "iPhone6,1":	return "iPhone 5s (GSM)"
			case "iPhone6,2":	return "iPhone 5s (GSM+CDMA)"
			case "iPhone7,1":	return "iPhone 6 Plus"
			case "iPhone7,2":	return "iPhone 6"
			case "iPod1,1":	return "iPod Touch 1G"
			case "iPod2,1":	return "iPod Touch 2G"
			case "iPod3,1":	return "iPod Touch 3G"
			case "iPod4,1":	return "iPod Touch 4G"
			case "iPod5,1":	return "iPod Touch 5G"
			case "iPad1,1":	return "iPad"
			case "iPad2,1":	return "iPad 2 (WiFi)"
			case "iPad2,2":	return "iPad 2 (GSM)"
			case "iPad2,3":	return "iPad 2 (CDMA)"
			case "iPad2,4":	return "iPad 2 (WiFi)"
			case "iPad2,5":	return "iPad Mini (WiFi)"
			case "iPad2,6":	return "iPad Mini (GSM)"
			case "iPad2,7":	return "iPad Mini (GSM+CDMA)"
			case "iPad3,1":	return "iPad 3 (WiFi)"
			case "iPad3,2":	return "iPad 3 (GSM+CDMA)"
			case "iPad3,3":	return "iPad 3 (GSM)"
			case "iPad3,4":	return "iPad 4 (WiFi)"
			case "iPad3,5":	return "iPad 4 (GSM)"
			case "iPad3,6":	return "iPad 4 (GSM+CDMA)"
			case "iPad4,4":	return "iPad mini Retina (WiFi)"
			case "iPad4,5":	return "iPad mini Retina (Cellular)"
			case "i386":		return "Simulator";
			case "x86_64":	return "Simulator";
			default:				return strHWMachine!
			}
		}
		else{
			return "[unknown]"
		}
	}
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.
		
		TRXLog.shared.appendLogLine("===============")
		TRXLog.shared.appendLogLine(self.hardwareName())
		
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


}

