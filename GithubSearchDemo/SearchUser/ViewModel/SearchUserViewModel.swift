//
//  SearchUserViewModel.swift
//  GithubSearchDemo
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import Foundation
import RxSwift

extension SearchUserViewController {
  class ViewModel {
    var userViewModels = BehaviorSubject(value: [UserCell.ViewModel]())
     
    private var currentUserName: String = "" {
      didSet {
        userViewModels.onNext([])
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
          
        let list = (try? self.userViewModels.value()) ?? []
        let newList = result.users.map { UserCell.ViewModel(user: $0) }
        self.userViewModels.onNext(list + newList)
        self.pageInfo = result.pageInfo
      }
    }
    
  }
}
