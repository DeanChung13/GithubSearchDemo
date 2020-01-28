//
//  GithubAPI.swift
//  GithubSearchDemo
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import Foundation
import Moya

enum GithubAPI {
  case searchUser(name: String, page: Int = 1)
}

extension GithubAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.github.com")!
  }
  
  var path: String {
    switch self {
    case .searchUser: return "/search/users"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .searchUser: return .get
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .searchUser(let name, let page):
      return .requestParameters(
        parameters: ["q": name,
                     "page": page],
        encoding: URLEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    return ["Content-Type": "application/json"]
  }
}
