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
    private var userViewModels: [UserCell.ViewModel] = [] {
      didSet {
        didLoadData?()
      }
    }
    private var currentUserName: String = "" {
      didSet {
        userViewModels.removeAll()
        pageInfo = PageInfo()
      }
    }
    private var pageInfo = PageInfo()
    
    var didLoadData: (() -> Void)?
    
    private var apiService: GithubService
    init(service: GithubService) {
      apiService = service
    }
    
    // MARK: - Public methods
    func searchUser(name: String) {
      currentUserName = name
      searchUserWithService()
    }
    
    func loadSearchUserNextPage() {
      searchUserWithService()
    }
    
    func searchUserWithService() {
      guard let nextPage = pageInfo[.next] else {
        // TODO: data to the end
        return
      }
      
      apiService.searchUser(name: currentUserName, nextPage: nextPage) { [weak self] (result) in
        guard let self = self else { return }
          
        self.userViewModels.append(contentsOf: result.users.map { UserCell.ViewModel(user: $0) })
        self.pageInfo = result.pageInfo
      }
    }
    
    func userCount() -> Int {
      return userViewModels.count
    }
    
    func userViewModel(index: Int) -> UserCell.ViewModel {
      return userViewModels[index]
    }
    
  }
}
