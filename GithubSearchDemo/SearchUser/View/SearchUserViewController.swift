//
//  SearchUserViewController.swift
//  GithubSearchDemo
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

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
    return view
  }()
  
  private let viewModel = ViewModel(service: GithubService())
  private let disposeBag = DisposeBag()
  
  // MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
    setupConstraints()
    bindViews()
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
  
  private func bindViews() {
    viewModel.userViewModels
      .bind(to: collectionView.rx.items(
        cellIdentifier: UserCell.reuseIdentifier,
        cellType: UserCell.self)) { [weak self] index, element, cell in
          
          guard let self = self else {
            return
          }
          
          cell.setup(viewModel: element)
          
          if index == ((try? self.viewModel.userViewModels.value()) ?? []).count - 1 {
            self.viewModel.loadSearchUserNextPage()
          }
    }
    .disposed(by: disposeBag)
    
    textField.rx.text.orEmpty.asObservable()
      .distinctUntilChanged()
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        
        guard let self = self else { return }
        
        if $0.isEmpty {
          self.viewModel.userViewModels.onNext([])
          return
        }
        self.viewModel.searchUser(name: $0)
      })
      .disposed(by: disposeBag)
    
  }
}
