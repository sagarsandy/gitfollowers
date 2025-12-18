//
//  FollowerCell.swift
//  GithubDemo
//
//  Created by Sagar on 18/12/25.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FollowerCell"
    
    let avatarImageView = AvatarImageView(frame: .zero)
    let userNameLabel = SSTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        
        layoutUI()
    }
    
    func set(follower: Follower) {
        userNameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            userNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

}
