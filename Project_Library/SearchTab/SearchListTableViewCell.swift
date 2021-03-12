//
//  SearchListTableViewCell.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/12.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {
    
    let totalStackView: UIStackView = UIStackView()
    let insideStackView: UIStackView = UIStackView()
    let titleLabel: UILabel = UILabel()
    let authorLabel: UILabel = UILabel()
    let publicationLabel: UILabel = UILabel()
    let thumbnailImage: UIImageView = UIImageView()
    
    var book: Book?
    var parentVC: UIViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: 외부 스택 뷰 설정, 배치
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        totalStackView.axis = .horizontal
        totalStackView.spacing = 12
        totalStackView.distribution = .fill
        totalStackView.alignment = .leading
        totalStackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        totalStackView.isLayoutMarginsRelativeArrangement = true
        
        contentView.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            totalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            totalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        
        // MARK: 이미지 뷰 설정, 배치
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImage.layer.cornerRadius = 8
        thumbnailImage.clipsToBounds = true
        thumbnailImage.contentMode = .scaleAspectFill
        thumbnailImage.backgroundColor = .gray100
        NSLayoutConstraint.activate([
            thumbnailImage.heightAnchor.constraint(equalToConstant: 105),
            thumbnailImage.widthAnchor.constraint(equalToConstant: 75)
        ])
        thumbnailImage.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        totalStackView.addArrangedSubview(thumbnailImage)
        
        
        // MARK: 우측 스택 뷰 설정, 배치
        insideStackView.translatesAutoresizingMaskIntoConstraints = false
        insideStackView.axis = .vertical
        insideStackView.spacing = 8
        insideStackView.distribution = .fill
        insideStackView.alignment = .fill
        insideStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        totalStackView.addArrangedSubview(insideStackView)
        
        
        // MARK: 타이틀 라벨 설정, 배치
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = .subtitle2
        titleLabel.textColor = .gray800
        insideStackView.addArrangedSubview(titleLabel)
        
        // MARK: 저자 라벨 설정, 배치
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.numberOfLines = 1
        authorLabel.lineBreakMode = .byTruncatingTail
        authorLabel.font = .body2
        authorLabel.textColor = .gray600
        insideStackView.addArrangedSubview(authorLabel)
        
        // MARK: 출판사 라벨 설정, 배치
        publicationLabel.translatesAutoresizingMaskIntoConstraints = false
        publicationLabel.numberOfLines = 1
        publicationLabel.lineBreakMode = .byTruncatingTail
        publicationLabel.font = .body2
        publicationLabel.textColor = .gray600
        insideStackView.addArrangedSubview(publicationLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(presentView(sender:)))
        self.addGestureRecognizer(gesture)

    }
    
    @objc func presentView(sender: UITapGestureRecognizer) {
        
        let bookDetailVC = BookDetailViewController()
        bookDetailVC.book = self.book
        bookDetailVC.thumbnailImage.image = self.thumbnailImage.image
        parentVC?.present(bookDetailVC, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
