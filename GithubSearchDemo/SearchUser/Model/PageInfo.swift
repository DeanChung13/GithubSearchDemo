//
//  PageInfo.swift
//  GithubSearchDemo
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import Foundation

struct PageInfo {
  private let dict: [String: String]
  init(rawDict: [String: String]) {
    dict = rawDict
  }
  
  init() {
    dict = ["next": "1"]
  }
}

extension PageInfo {
  enum Name: String {
    case first
    case prev
    case next
    case last
  }
  
  subscript(name: Name) -> Int? {
    get {
      guard let page = dict[name.rawValue],
        let pageNumber = Int(page) else {
        return nil
      }
      return pageNumber
    }
  }
}
