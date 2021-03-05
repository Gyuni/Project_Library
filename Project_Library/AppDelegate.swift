//
//  AppDelegate.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = UITabBarController()

        let roomTabVC = RoomTabViewController()
        let roomTabNavController = UINavigationController(rootViewController: roomTabVC)
        roomTabNavController.navigationBar.prefersLargeTitles = true
        let roomTabBarItem = UITabBarItem(title: "Room", image: nil, selectedImage: nil)
        roomTabNavController.tabBarItem = roomTabBarItem
        
        
        let noticeTabVC = NoticeTabViewController()
        let noticeTabNavController = UINavigationController(rootViewController: noticeTabVC)
        noticeTabNavController.navigationBar.prefersLargeTitles = true
        let noticeTabBarItem = UITabBarItem(title: "Notice", image: nil, selectedImage: nil)
        noticeTabNavController.tabBarItem = noticeTabBarItem
        
        let searchTabVC = SearchTabViewController()
        let searchTabNavController = UINavigationController(rootViewController: searchTabVC)
        searchTabNavController.navigationBar.prefersLargeTitles = true
        let searchTabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        searchTabNavController.tabBarItem = searchTabBarItem
        
        let settingTabVC = SettingTabViewController()
        let settingTabNavController = UINavigationController(rootViewController: settingTabVC)
        settingTabNavController.navigationBar.prefersLargeTitles = true
        let settingTabBarItem = UITabBarItem(title: "Setting", image: nil, selectedImage: nil)
        settingTabNavController.tabBarItem = settingTabBarItem
        
        tabBarController.viewControllers = [roomTabNavController, noticeTabNavController, searchTabNavController, settingTabNavController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

