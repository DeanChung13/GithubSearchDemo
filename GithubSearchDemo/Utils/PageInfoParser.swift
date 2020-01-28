//
//  PageInfoParser.swift
//  GithubSearchDemo
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import Foundation

struct PageInfoParser {
  enum ParseError: Error {
    case rawStringNil
    case cannotGetPage
    case cannotGetKey
  }
  
  private let rawString: String
  init(rawString: String?) throws {
    guard let string = rawString else {
      throw ParseError.rawStringNil
    }
    self.rawString = string
  }
  
  func parseSingle(rawString: String) throws -> (key: String, page: String) {
    var result: NSString?
    let scanner = Scanner(string: rawString)
    scanner.scanUpTo("page=", into: &result)
    scanner.scanString("page=", into: &result)
    scanner.scanUpTo("&", into: &result)
    let rawPage = result
    
    scanner.scanUpTo("rel=\"", into: &result)
    scanner.scanString("rel=\"", into: &result)
    scanner.scanUpTo("\"", into: &result)
    let rawKey = result

    guard let page = rawPage else {
      throw ParseError.cannotGetPage
    }
    guard let key = rawKey else {
      throw ParseError.cannotGetKey
    }
    return (key as String, page as String)
  }
  
  func parseAll() throws -> PageInfo {
    var dict: [String: String] = [:]
    for item in rawString.components(separatedBy: ",") {
      let (key, page) = try parseSingle(rawString: item)
      dict[key] = page
    }
    return PageInfo(rawDict: dict)
  }
}
