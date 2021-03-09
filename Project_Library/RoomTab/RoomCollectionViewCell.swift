//
//  RoomCollectionViewCell.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/09.
//

import UIKit

class RoomCollectionViewCell: UICollectionViewCell {
    
    let nameLabel: UILabel = UILabel()
    let capacityLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.backgroundColor = .systemBlue
        
        capacityLabel.translatesAutoresizingMaskIntoConstraints = false
        capacityLabel.textColor = .gray800
        capacityLabel.font = .head2
        contentView.addSubview(capacityLabel)
        NSLayoutConstraint.activate([
            capacityLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            capacityLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .gray700
        nameLabel.font = .head3
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: self.capacityLabel.topAnchor, constant: -16)
        ])
        
    }
}
