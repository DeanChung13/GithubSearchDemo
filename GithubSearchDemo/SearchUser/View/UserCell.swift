//
//  UserCell.swift
//  GithubSearchDemo
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
  static let reuseIdentifier = "UserCell"
  
  // MARK: - Lazy properties
  lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .red
    return imageView
  }()
  
  lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = .blue
    label.font = UIFont.systemFont(ofSize: 20)
    label.numberOfLines = 0
    return label
  }()
  
  
  // MARK: - view lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupSubviews() {
    addSubview(avatarImageView)
    addSubview(nameLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
      avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
      avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
      avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1.0),
      
      nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8.0),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0)
    ])
  }
}
