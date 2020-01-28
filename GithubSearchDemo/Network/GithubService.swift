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
  
  func searchUser(name: String, nextPage: Int,
                  completion: (SearchUserResult) -> Void) {
    
  }
}
