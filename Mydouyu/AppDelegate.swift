//
//  AppDelegate.swift
//  Mydouyuyyyy
//
//  Created by o g m on 2018/10/24.
//  Copyright © 2018 o g m. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init()
        self.window?.frame = UIScreen.main.bounds
        self.window?.backgroundColor = UIColor.white
        
        let vc01 = HomeViewController()
        vc01.title = ""
        //        vc01.view.backgroundColor = UIColor.green
        let nav01 = UINavigationController(rootViewController: vc01)
//        nav01.setNavigationBarHidden(true, animated: true)
        
        let vc02 = UIViewController()
        vc02.title = "视图2"
        vc02.view.backgroundColor = UIColor.yellow
        let nav02 = UINavigationController(rootViewController: vc02)
        
        
        let vc03 = UIViewController()
        vc03.title = "视图3"
        vc03.view.backgroundColor = UIColor.orange
        let nav03 = UINavigationController(rootViewController: vc03)
        
        
        let vc04 = UIViewController()
        vc04.title = "视图4"
        vc04.view.backgroundColor = UIColor.blue
        let nav04 = UINavigationController(rootViewController: vc04)
        
        
        
        
        //tabbarController
        let tabbarController = UITabBarController()
        //底部bar背景颜色
        tabbarController.tabBar.barTintColor = UIColor.black
        
        tabbarController.viewControllers = [nav01,nav02,nav03,nav04]
        //默认被选中
        tabbarController.selectedIndex = 0
        
        tabbarController.tabBar.isUserInteractionEnabled = true
        tabbarController.tabBar.backgroundColor = UIColor.white
        tabbarController.tabBar.backgroundImage = UIImage(named: "")
        tabbarController.tabBar.selectionIndicatorImage = UIImage(named: "")
        
        // 设置标题，未选中状态图标，选中状态图标
        let barItem01 = UITabBarItem(title: "首页", image: UIImage(named: "btn_home_normal"), selectedImage: UIImage(named: "btn_home_selected"))
        vc01.tabBarItem = barItem01
        let barItem02 = UITabBarItem(title: "第2视图", image: UIImage(named: "tabbar02_normal"), selectedImage: UIImage(named: "tabbar02_selected"))
        vc02.tabBarItem = barItem02
        let barItem03 = UITabBarItem(title: "第3视图", image: UIImage(named: "tabbar03_normal"), selectedImage: UIImage(named: "tabbar03_selected"))
        vc03.tabBarItem = barItem03
        let barItem04 = UITabBarItem(title: "第4视图", image: UIImage(named: "tabbar04_normal"), selectedImage: UIImage(named: "tabbar04_selected"))
        vc04.tabBarItem = barItem04
       
        
        // 设置字体颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green], for: UIControl.State.selected)
        // 设置字体大小
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8.0)], for:
            .normal)
        // 设置字体偏移
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0)
        
        // 设置图标选中时颜色
        UITabBar.appearance().tintColor = UIColor.red
        
        self.window?.rootViewController = tabbarController
        self.window?.makeKeyAndVisible()
        
        
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

