//
//  AppDelegate.swift
//  Todoey
//
//  Created by Yi Ting Lu on 2019/7/31.
//  Copyright © 2019 Yi Ting Lu. All rights reserved.
//

import UIKit
import RealmSwift



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

      //  print(Realm.Configuration.defaultConfiguration.fileURL)
   
        
        do{
            _ = try Realm()
        } catch{
            print("Error initialising new realm, \(error)")
        }
        
       
        
        
        return true
    }


}

