//
//  SearchUserViewController.swift
//  GithubSearchDemo
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController {
  
  // MARK: - Constants
  private struct Constant {
    static let padding = CGFloat(16)
    static let itemHeight = CGFloat(100)
  }
  
  // MARK: - Lazy properties
  lazy var rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = Constant.padding
    return stackView
  }()
  
  lazy var textField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Input User name to Search"
    textField.delegate = self
    return textField
  }()
  
  lazy var normalFlowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: view.bounds.width - Constant.padding*2, height: Constant.itemHeight)
    return flowLayout
  }()
  
  lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: self.normalFlowLayout)
    view.backgroundColor = .white
    view.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseIdentifier)
    view.dataSource = self
    return view
  }()
  
  let viewModel = ViewModel(service: GithubService())
  
  // MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
    setupConstraints()
    initBinding()
  }
  
  private func setupSubviews() {
    view.backgroundColor = .white
    view.addSubview(rootStackView)
    rootStackView.addArrangedSubview(textField)
    rootStackView.addArrangedSubview(collectionView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      rootStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      rootStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      rootStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
    ])
  }
  
  private func initBinding() {
    viewModel.didLoadData = { [weak self] in
      self?.collectionView.reloadData()
    }
  }
}

extension SearchUserViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.userViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.reuseIdentifier, for: indexPath) as? UserCell else {
      fatalError("Cannot get UserCell")
    }
    let userViewModel = viewModel.userViewModel(index: indexPath.item)
    cell.setup(viewModel: userViewModel)
    return cell
  }
}

extension SearchUserViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text,
      let range = Range(range, in: text) else {
      return true
    }
    let result = text.replacingCharacters(in: range , with: string)
    viewModel.searchUser(name: result)
    return true
  }
}
