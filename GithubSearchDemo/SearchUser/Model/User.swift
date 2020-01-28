//
//  User.swift
//  GithubSearchDemo
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import Foundation

struct User: Codable {
  let id: Int
  let name: String
  let avatarUrlString: String
  
  enum CodingKeys: String, CodingKey {
    case name = "login"
    case avatarUrlString = "avatar_url"
    case id
  }
}
