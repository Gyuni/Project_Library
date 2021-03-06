//
//  NoticeTableViewCell.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/06.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    
    weak var parnetVC: UIViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: 스택 뷰 선언, 설정, 배치
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
        
        // MARK: 타이틀 라벨 선언, 설정, 배치
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        
        // MARK: 데이트 라벨 선언, 설정, 배치
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(dateLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pushView(sender:)))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func pushView(sender: UITapGestureRecognizer) {
        /*
        let vc = ThirdViewController()
        vc.cityName = self.nameLabel.text
        
        vc.weatherImageView.image = self.weatherImageView.image
        
        vc.nameLabel.text = self.nameLabel.text
        
        vc.temperatureLabel.text = self.temperatureLabel.text
        vc.temperatureLabel.textColor = self.temperatureLabel.textColor
        
        vc.rainfallProbabilityLabel.text = self.rainfallProbabilityLabel.text
        vc.rainfallProbabilityLabel.textColor = self.rainfallProbabilityLabel.textColor
        
        parent?.navigationController?.pushViewController(vc, animated: true)
 */
        print("얍")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
