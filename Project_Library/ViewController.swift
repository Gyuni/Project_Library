//
//  ViewController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
        let roomTabVC = RoomTabViewController()
        let roomTabBarItem = UITabBarItem(title: "Room", image: nil, selectedImage: nil)
        roomTabVC.tabBarItem = roomTabBarItem
        
        let noticeTabVC = NoticeTabViewController()
        let noticeTabBarItem = UITabBarItem(title: "Notice", image: nil, selectedImage: nil)
        noticeTabVC.tabBarItem = noticeTabBarItem
        
        self.viewControllers = [roomTabVC, noticeTabVC]
 */
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("\(viewController.title!)")
    }
    
}

