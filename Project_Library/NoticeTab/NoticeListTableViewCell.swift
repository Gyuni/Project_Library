//
//  NoticeTableViewCell.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/06.
//

import UIKit

class NoticeListTableViewCell: UITableViewCell {
    
    let stackView: UIStackView = UIStackView()
    let titleLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    
    var notice: Notice?
    var parentVC: UIViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: 스택 뷰 설정, 배치
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
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
        
        // MARK: 타이틀 라벨, 설정, 배치
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .gray800
        titleLabel.font = .subtitle2
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        stackView.addArrangedSubview(titleLabel)
        
        // MARK: 데이트 라벨, 설정, 배치
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .gray600
        dateLabel.font = .caption
        stackView.addArrangedSubview(dateLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pushView(sender:)))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func pushView(sender: UITapGestureRecognizer) {
        
        let noticeArticleVC = NoticeArticleViewController()
        noticeArticleVC.notice = self.notice
        
        parentVC?.navigationController?.pushViewController(noticeArticleVC, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
