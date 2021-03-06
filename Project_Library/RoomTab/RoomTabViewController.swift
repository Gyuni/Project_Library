//
//  RoomTabViewController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import UIKit
import SnapKit

class RoomTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = "Room Tab Title"
        self.view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveRoomsNotification(_:)), name: DidReceiveRoomsNotification, object: nil)
    }
    
    @objc func didReceiveRoomsNotification(_ noti: Notification) {
        print(noti)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestRoomList()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
