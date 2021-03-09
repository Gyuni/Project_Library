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
        window?.backgroundColor = .white000
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .secondary_blue
        tabBarController.tabBar.backgroundColor = .white000
        tabBarController.tabBar.isTranslucent = false

        let roomTabVC = RoomTabViewController()
        let roomTabNavController = UINavigationController(rootViewController: roomTabVC)
        setNavControllerStyle(navController: roomTabNavController)
        let roomTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "room_tab_unselected"), selectedImage: UIImage(named: "room_tab_selected"))
        roomTabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
        roomTabNavController.tabBarItem = roomTabBarItem
        
        let noticeTabVC = NoticeTabViewController()
        let noticeTabNavController = UINavigationController(rootViewController: noticeTabVC)
        setNavControllerStyle(navController: noticeTabNavController)
        let noticeTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "notice_tab_unselected"), selectedImage: UIImage(named: "notice_tab_selected"))
        noticeTabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
        noticeTabNavController.tabBarItem = noticeTabBarItem
        
        let searchTabVC = SearchTabViewController()
        let searchTabNavController = UINavigationController(rootViewController: searchTabVC)
        setNavControllerStyle(navController: searchTabNavController)
        let searchTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "search_tab_unselected"), selectedImage: UIImage(named: "search_tab_selected"))
        searchTabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
        searchTabNavController.tabBarItem = searchTabBarItem
        
        let settingTabVC = SettingTabViewController()
        let settingTabNavController = UINavigationController(rootViewController: settingTabVC)
        setNavControllerStyle(navController: settingTabNavController)
        let settingTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "setting_tab_unselected"), selectedImage: UIImage(named: "setting_tab_selected"))
        settingTabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
        settingTabNavController.tabBarItem = settingTabBarItem
        
        tabBarController.viewControllers = [roomTabNavController, noticeTabNavController, searchTabNavController, settingTabNavController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func setNavControllerStyle(navController: UINavigationController) {
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.backgroundColor = .white000
        navController.navigationBar.tintColor = .secondary_blue
        navController.navigationBar.isTranslucent = false
        // navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gray800]
        navController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.gray800]
        navController.navigationBar.largeTitleTextAttributes = [.font: UIFont.head1]
    }
    
}

