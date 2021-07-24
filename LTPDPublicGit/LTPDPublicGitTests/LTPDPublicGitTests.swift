//
//  LTPDPublicGitTests.swift
//  LTPDPublicGitTests
//
//  Created by Sachindra on 23/7/21.
//

import XCTest
@testable import LTPDPublicGit

class LTPDPublicGitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidParsing() throws {
        let mockAPIService = GithubMockAPIService()
        mockAPIService.mockResponseType = .valid(validResponse)
        let githubRepository = GithubRepository(apiService: mockAPIService)
        githubRepository.fetchRespositories { (record, next, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(record)
            XCTAssertNotNil(next)
            XCTAssertFalse(record!.isEmpty)
        }
    }

    func testinValidParsing() throws {
        let mockAPIService = GithubMockAPIService()
        mockAPIService.mockResponseType = .invalid(inValidResponse)
        let githubRepository = GithubRepository(apiService: mockAPIService)
        githubRepository.fetchRespositories { (record, next, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(record)
        }
    }

    func testError() throws {
        let mockAPIService = GithubMockAPIService()
        mockAPIService.mockResponseType = .error(APIServiceErrors.genericError)
        let githubRepository = GithubRepository(apiService: mockAPIService)
        githubRepository.fetchRespositories { (record, next, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(record)
        }
    }

}

//Can think of a better place to organize these
fileprivate let validResponse = ["pagelen": 10,
                                 "values": [["full_name": "opensymphony/xwork",
                                            "type": "repository",
                                            "created_on": "2011-06-06T03:40:09.505792+00:00",
                                            "owner": [
                                                "display_name": "opensymphony",
                                                "uuid": "{cedfd0d1-899f-49de-acf7-a2fa8e924b6f}",
                                                "links": [
                                                    "self": [
                                                        "href": "https://api.bitbucket.org/2.0/users/%7Bcedfd0d1-899f-49de-acf7-a2fa8e924b6f%7D"
                                                    ],
                                                    "html": [
                                                        "href": "https://bitbucket.org/%7Bcedfd0d1-899f-49de-acf7-a2fa8e924b6f%7D/"
                                                    ],
                                                    "avatar": [
                                                        "href": "https://bitbucket.org/account/opensymphony/avatar/"
                                                    ]
                                                ]
                                            ]
                                 ]],
                                 "next": "https://api.bitbucket.org/2.0/repositories?after=2011-09-03T12%3A33%3A16.028393%2B00%3A00"] as [String : Any]

fileprivate let inValidResponse = ["pagelen": 10,
                                   "values": [["fullName": "opensymphony/xwork",
                                              "Type": "repository",
                                              "created_on": "2011-06-06T03:40:09.505792+00:00",
                                              "Owner": [
                                                  "display_name": "opensymphony",
                                                  "uuid": "{cedfd0d1-899f-49de-acf7-a2fa8e924b6f}",
                                                  "links": [
                                                      "self": [
                                                          "href": "https://api.bitbucket.org/2.0/users/%7Bcedfd0d1-899f-49de-acf7-a2fa8e924b6f%7D"
                                                      ],
                                                      "html": [
                                                          "href": "https://bitbucket.org/%7Bcedfd0d1-899f-49de-acf7-a2fa8e924b6f%7D/"
                                                      ],
                                                      "avatar": [
                                                          "href": "https://bitbucket.org/account/opensymphony/avatar/"
                                                      ]
                                                  ]
                                              ]
                                   ]],
                                   "next": "https://api.bitbucket.org/2.0/repositories?after=2011-09-03T12%3A33%3A16.028393%2B00%3A00"] as [String : Any]
