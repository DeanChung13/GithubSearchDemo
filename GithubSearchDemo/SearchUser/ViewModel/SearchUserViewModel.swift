//
//  SearchUserViewModel.swift
//  GithubSearchDemo
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import Foundation

extension SearchUserViewController {
  class ViewModel {
    var userViewModels: [UserCell.ViewModel] = [] {
      didSet {
        didLoadData?()
      }
    }
    var didLoadData: (() -> Void)?
    
    private var apiService: GithubService
    init(service: GithubService) {
      apiService = service
    }
    
    // MARK: - Public methods
    func searchUser(name: String) {
      apiService.searchUser(name: name, nextPage: 1) { [weak self] (result) in
        guard let self = self else { return }
          
        self.userViewModels.append(contentsOf: result.users.map { UserCell.ViewModel(user: $0) })
      }
    }
    
    func userViewModel(index: Int) -> UserCell.ViewModel {
      return userViewModels[index]
    }
  }
}
