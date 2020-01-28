//
//  GithubAPITests.swift
//  GithubSearchDemoTests
//
//  Created by Dean Chung on 2020/1/28.
//  Copyright © 2020 Dean Chung. All rights reserved.
//

import XCTest
@testable import GithubSearchDemo
import Moya

class GithubAPITests: XCTestCase {
  
  private func searchUserEndpointClosure(_ target: GithubAPI) -> Endpoint {
    return Endpoint(
      url: URL(target: target).absoluteString,
      sampleResponseClosure: { .networkResponse(200, target.testSampleData)},
      method: target.method,
      task: target.task,
      httpHeaderFields: target.headers)
  }
  
  func testSearchUser_returnNameAndAvatarURL() {
      
    // given
    let sut = MoyaProvider<GithubAPI>(
      endpointClosure: searchUserEndpointClosure,
      stubClosure: MoyaProvider.immediatelyStub)
      
    // when
    sut.request(.searchUser(name: "mojombo")) { (result) in
      switch result {
      case .success(let response):
        do {
          let firstUser = try response.map(SearchResponse<User>.self).items.first!
          
          // then
          XCTAssertEqual(firstUser.name, "mojombo")
        } catch {
          XCTFail(error.localizedDescription)
        }
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
  }
}

private extension GithubAPI {
  var testSampleData: Data {
    switch self {
    case .searchUser:
      let url = Bundle(for: GithubAPITests.self).url(forResource: "searchUserSample_mojombo", withExtension: "json")!
         return try! Data(contentsOf: url)
    }
  }
}
