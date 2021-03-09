//
//  RoomTabViewController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import UIKit
import SnapKit

class RoomTabViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var rooms: [Room] = []
    let roomCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let cellIdentifier: String = "roomCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveRoomsNotification(_:)), name: DidReceiveRoomsNotification, object: nil)
        
        requestRoomList()
        setupView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestRoomList()
    }
    
    @objc func didReceiveRoomsNotification(_ noti: Notification) {
        guard let response: RoomListResponse = noti.userInfo?["rooms"] as? RoomListResponse else { return }
        
        self.rooms = response.data.list
        
        DispatchQueue.main.async {
            self.roomCollectionView.reloadData()
        }
    }
    
    private func setupView() {
        
        let margins = view.layoutMarginsGuide
        
        self.navigationController?.navigationBar.topItem?.title = "열람실"
        self.view.backgroundColor = .white000
        
        // layout.scrollDirection = .horizontal
        roomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        roomCollectionView.setCollectionViewLayout(layout, animated: true)
        roomCollectionView.dataSource = self
        roomCollectionView.delegate = self
        roomCollectionView.backgroundColor = .white000
        roomCollectionView.register(RoomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.view.addSubview(roomCollectionView)
        
        NSLayoutConstraint.activate([
            roomCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roomCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            roomCollectionView.topAnchor.constraint(equalTo: margins.topAnchor),
            roomCollectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
        self.roomCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: RoomCollectionViewCell = roomCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? RoomCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        
        let room: Room = self.rooms[indexPath.item]
        cell.nameLabel.text = room.name
        cell.capacityLabel.text = String(room.occupied)
        
        return cell
    }
    
    //셀크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = (roomCollectionView.frame.width - 24 ) / 3
        print(size)
        return CGSize(width: size, height: size)

    }

    //위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    //좌우간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}
