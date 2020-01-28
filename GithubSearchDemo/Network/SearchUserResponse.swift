//
//  SearchUserResponse.swift
//  GithubSearchDemo
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import Foundation

struct SearchResponse<T: Codable>: Codable {
  let items: [T]
  let totalCount: Int
  
  enum CodingKeys: String, CodingKey {
    case totalCount = "total_count"
    case items
  }
}

struct SearchUserResult {
  let users: [User]
  let pageInfo: PageInfo
}
