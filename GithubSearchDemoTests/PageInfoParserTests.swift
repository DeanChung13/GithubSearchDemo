//
//  PageInfoParserTests.swift
//  GithubSearchDemoTests
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import XCTest
@testable import GithubSearchDemo

class PageInfoParserTests: XCTestCase {
  
  func testSingleLinkParser() {
    do {
      // given
      let sut = try PageInfoParser(rawString: "")
      
      // when
      let pageLink = try sut.parseSingle(rawString:
        "<https://api.github.com/search/users?page=2&q=D>; rel=\"next\"")
      
      // then
      XCTAssertEqual(pageLink.page, "2")
      XCTAssertEqual(pageLink.key, "next")
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testParseAll_shouldReturnLast34() {
    do {
      // given
      let sut = try PageInfoParser(rawString: "<https://api.github.com/search/users?page=2&q=D>; rel=\"next\", <https://api.github.com/search/users?page=34&q=D>; rel=\"last\"")
      
      // when
      let pageInfo = try sut.parseAll()
      
      // then
      XCTAssertEqual(pageInfo[.next], 2)
      XCTAssertEqual(pageInfo[.last], 34)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
  
}
