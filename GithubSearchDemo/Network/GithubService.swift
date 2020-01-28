//
//  GithubService.swift
//  GithubSearchDemo
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import Foundation
import Moya

struct GithubService {
  let provider = MoyaProvider<GithubAPI>()
  
  func searchUser(name: String,
                  nextPage: Int,
                  completion: @escaping (SearchUserResult) -> Void) {
    
    provider.request(.searchUser(name: name, page: 1)) { (result) in
      
      switch result {
      case .success(let response):
        do {
          let users = try response.map(SearchResponse<User>.self).items
          completion(SearchUserResult(users: users))
        } catch {
          print(error.localizedDescription)
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
