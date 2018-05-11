//
//  AppDelegate.swift
//  RalphRoberts
//
//  Created by John Scott on 09/05/2018.
//  Copyright © 2018 John Scott. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let hash = "HelloWorld".data(using: .utf8)?.md5().hexEncodedString()
        {
            print(hash)
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        reloadCharacterData()
    }
    
    func reloadCharacterData()
    {
        MarvelConnector.getCharacters(range: 0..<50) { (characters, error) in
            
            guard error == nil else
            {
                var message : String?
                
                if let marvelError = error as? MarvelError
                {
                    switch (marvelError)
                    {
                    case .invalidUrl:
                        message = "The URL accessed is invalid. This is a bug"
                    case .emptyServerResponse:
                        message = "The server responded with nothing, zip, nadda. Not much can be done here."
                    case .badServerResponse:
                        message = "The server responded with something not understood. This is a bug"
                    case let .serverMessage(serverMessage):
                        message = serverMessage.message
                    }
                }
                else if let urlError = error as? URLError,
                    let localizedDescription = urlError.userInfo[NSLocalizedDescriptionKey] as? String
                {
                    message = localizedDescription
                }
                else
                {
                    message = "A mysterious thing happened. This is probably a bug"
                }
                
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    self.reloadCharacterData()
                }))
                
                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            if let tabBarController = self.window?.rootViewController as? UITabBarController, let viewControllers = tabBarController.viewControllers
            {
                for (index, viewController) in viewControllers.enumerated()
                {
                    if let charactersViewController = viewController as? CharactersViewController
                    {
                        charactersViewController.characters = characters
                        tabBarController.selectedIndex = index
                    }
                    else if let navigationViewController = viewController as? UINavigationController, let charactersViewController = navigationViewController.viewControllers.first as? CharactersViewController
                    {
                        charactersViewController.characters = characters
                        tabBarController.selectedIndex = index
                    }
                }
            }
        }

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

