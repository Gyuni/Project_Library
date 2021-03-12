//
//  BookDetailViewController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/12.
//

import UIKit

class BookDetailViewController: UIViewController {

    var book: Book?
    
    let rootStackView: UIStackView = UIStackView()
    let infoStackView: UIStackView = UIStackView()
    let titleLabel: UILabel = UILabel()
    let authorLabel: UILabel = UILabel()
    let publicationLabel: UILabel = UILabel()
    let stateLabel: UILabel = UILabel()
    let thumbnailImage: UIImageView = UIImageView()
    let dismissButton: UIButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white000
        let margins = view.layoutMarginsGuide
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis = .vertical
        rootStackView.spacing = 16
        rootStackView.distribution = .fill
        rootStackView.alignment = .fill
        rootStackView.layoutMargins = UIEdgeInsets(top: 32, left: 16, bottom: 16, right: 16)
        rootStackView.isLayoutMarginsRelativeArrangement = true
        
        view.addSubview(rootStackView)
        
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            rootStackView.topAnchor.constraint(equalTo: margins.topAnchor)
        ])
        
        // MARK: 이미지 뷰 설정, 배치
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImage.clipsToBounds = true
        thumbnailImage.contentMode = .scaleAspectFit
        thumbnailImage.backgroundColor = .white000
        thumbnailImage.layer.cornerRadius = 8
        NSLayoutConstraint.activate([
            thumbnailImage.heightAnchor.constraint(equalToConstant: 200),
        ])
        thumbnailImage.setContentHuggingPriority(.defaultHigh, for: .vertical)
        rootStackView.addArrangedSubview(thumbnailImage)
        
        if thumbnailImage.image == nil {
            thumbnailImage.backgroundColor = .gray100
        }
        
        
        // MARK: 정보 스택뷰 설정
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .vertical
        infoStackView.spacing = 12
        infoStackView.distribution = .fill
        infoStackView.alignment = .fill
        infoStackView.setContentHuggingPriority(.defaultLow, for: .vertical)
        rootStackView.addArrangedSubview(infoStackView)
        
        // MARK: 타이틀 라벨 설정, 배치
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byCharWrapping
        titleLabel.font = .head1
        titleLabel.textColor = .gray800
        titleLabel.text = self.book?.titleStatement
        infoStackView.addArrangedSubview(titleLabel)
        
        // MARK: 저자 라벨 설정, 배치
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.numberOfLines = 0
        authorLabel.lineBreakMode = .byCharWrapping
        authorLabel.font = .body1
        authorLabel.textColor = .gray700
        authorLabel.text = self.book?.author
        infoStackView.addArrangedSubview(authorLabel)
        
        // MARK: 출판사 라벨 설정, 배치
        publicationLabel.translatesAutoresizingMaskIntoConstraints = false
        publicationLabel.numberOfLines = 0
        publicationLabel.lineBreakMode = .byCharWrapping
        publicationLabel.font = .body1
        publicationLabel.textColor = .gray700
        publicationLabel.text = self.book?.publication
        infoStackView.addArrangedSubview(publicationLabel)
        
        // MARK: 재고 여부 라벨 설정, 배치
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.numberOfLines = 0
        stateLabel.lineBreakMode = .byCharWrapping
        stateLabel.font = .body1
        stateLabel.textColor = .gray700
        stateLabel.text = self.book?.branchVolumes[0].state
        
        infoStackView.addArrangedSubview(stateLabel)
        
        // MARK: 닫기 버튼 설정, 배치
        self.view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -16),
            dismissButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            dismissButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        dismissButton.backgroundColor = .secondary_blue
        dismissButton.layer.cornerRadius = 8
        
        dismissButton.setTitle("닫기", for: .normal)
        dismissButton.titleLabel?.font = .button1
        dismissButton.setTitleColor(.white000, for: .normal)
        dismissButton.addTarget(self, action: #selector(didButtonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc
    func didButtonPressed(sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
}
