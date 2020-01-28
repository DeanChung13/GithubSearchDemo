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
    var users: [User] = [] {
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
          
        self.users = result.users
      }
    }
  }
}
