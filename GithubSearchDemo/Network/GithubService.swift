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
  var currentRequest: Cancellable?
  
  mutating func searchUser(name: String,
                  nextPage: Int,
                  completion: @escaping (SearchUserResult) -> Void) {
    
    self.currentRequest?.cancel()
    
    let request = provider.request(.searchUser(name: name, page: 1)) { (result) in
      
      switch result {
      case .success(let response):
        let rawLink = response.response?.allHeaderFields["Link"] as? String
        
        do {
          let users = try response.map(SearchResponse<User>.self).items
          let pageInfo = try PageInfoParser(rawString: rawLink).parseAll()
          completion(SearchUserResult(users: users, pageInfo: pageInfo))
        } catch {
          print(error.localizedDescription)
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    
    self.currentRequest = request
  }
}
