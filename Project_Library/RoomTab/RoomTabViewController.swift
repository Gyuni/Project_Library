//
//  RoomTabViewController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import UIKit

class RoomTabViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var rooms: [Room] = []
    let roomCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let cellIdentifier: String = "roomCell"
    let cellSize = 120

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
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        roomCollectionView.collectionViewLayout = layout
        roomCollectionView.showsHorizontalScrollIndicator = false
        
        roomCollectionView.register(RoomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)

        self.view.addSubview(roomCollectionView)
        
        NSLayoutConstraint.activate([
            roomCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roomCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            roomCollectionView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16),
            roomCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(cellSize))
        ])
        
        roomCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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
        
        cell.capacityLabel.text = room.capacity
        let attributedCapacityText = NSMutableAttributedString(string: room.capacity)
        let boldLength = String(room.available).count
        attributedCapacityText.addAttribute(.font, value: UIFont.widget1, range: NSRange(location: 0, length: boldLength))
        cell.capacityLabel.attributedText = attributedCapacityText
        
        setCellBackgroundColor(cell: cell, room: room)

        return cell
    }
    
    private func setCellBackgroundColor(cell: RoomCollectionViewCell, room: Room) {
        if room.activeTotal == 0 {
            cell.contentView.backgroundColor = .gray300
            cell.nameLabel.textColor = .gray500
            cell.capacityLabel.textColor = .gray500
            return
        }
        
        if room.congestion > 2/3 {
            cell.contentView.backgroundColor = .room_background_red
            cell.nameLabel.textColor = .room_text_red
            cell.capacityLabel.textColor = .room_text_red
        } else if room.congestion > 1/3 {
            cell.contentView.backgroundColor = .room_background_yellow
            cell.nameLabel.textColor = .room_text_yellow
            cell.capacityLabel.textColor = .room_text_yellow
        } else {
            cell.contentView.backgroundColor = .room_background_green
            cell.nameLabel.textColor = .room_text_green
            cell.capacityLabel.textColor = .room_text_green
        }
    }
    
    //셀크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        /*
        // 360 아래(아이폰SE 1세대)는 한 라인에 2개 셀, 그 외는 3개 셀
        // 맥스는 어떡하지?
        var numberOfCellsInLine: CGFloat
        
        if roomCollectionView.frame.width >= 360 {
            numberOfCellsInLine = 3
        } else {
            numberOfCellsInLine = 2
        }
        
        let size = (roomCollectionView.frame.width - 32 - (numberOfCellsInLine-1)*12 ) / numberOfCellsInLine
        */
        
        
        return CGSize(width: cellSize, height: cellSize)
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
