//
//  AppDelegate.swift
//  TheBooks
//
//  Created by Eric Ferreira on 3/18/17.
//  Copyright © 2017 Eric Ferreira. All rights reserved.
//

import UIKit
import CoreData
import BKPasscodeView

private let PASSCODE_KEY = "passcode_key"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BKPasscodeLockScreenManagerDelegate {
	var window: UIWindow?
	
	//MARK: Authentication
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		BKPasscodeLockScreenManager.shared().delegate = self
		BKPasscodeLockScreenManager.shared().showLockScreen(false)
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// This will present the auth each time the app loses focus.
		BKPasscodeLockScreenManager.shared().showLockScreen(true)
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		displaying?.startTouchIDAuthenticationIfPossible()
	}
	
	func lockScreenManagerShouldShowLockScreen(_ aManager: BKPasscodeLockScreenManager!) -> Bool {
		return true
	}
	
	var displaying: BKPasscodeViewController?
	
	func lockScreenManagerPasscodeViewController(_ aManager: BKPasscodeLockScreenManager!) -> UIViewController! {
		displaying = Authentication.getInstance()
		
		return displaying
	}
	
	//MARK: Screen orientations
	
	func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
		return [.portrait, .portraitUpsideDown]
	}

	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentContainer = {
	    /*
	     The persistent container for the application. This implementation
	     creates and returns a container, having loaded the store for the
	     application to it. This property is optional since there are legitimate
	     error conditions that could cause the creation of the store to fail.
	    */
	    let container = NSPersistentContainer(name: "TheBooks")

	    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
	        if let error = error as NSError? {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	             
	            /*
	             Typical reasons for an error here include:
	             * The parent directory does not exist, cannot be created, or disallows writing.
	             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
	             * The device is out of space.
	             * The store could not be migrated to the current model version.
	             Check the error message to determine what the actual problem was.
	             */
	            fatalError("Unresolved error \(error), \(error.userInfo)")
	        }
	    })

	    return container
	}()
	
	var context: NSManagedObjectContext {
		return self.persistentContainer.viewContext
	}

	// MARK: - Core Data Saving support

	func saveContext () {
	    let context = persistentContainer.viewContext
	    if context.hasChanges {
	        do {
	            try context.save()
	        } catch {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	            let nserror = error as NSError
	            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
	        }
	    }
	}
}

