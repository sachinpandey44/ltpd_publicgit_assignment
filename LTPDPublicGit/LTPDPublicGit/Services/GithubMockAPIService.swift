//
//  GithubMockAPIService.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 24/7/21.
//

import Foundation

enum MockAPIServiceResponse {
    case valid([String : Any])
    case invalid([String : Any])
    case error(APIServiceErrors)
}

class GithubMockAPIService: GithubAPIServiceProtocol {
    var mockResponseType: MockAPIServiceResponse!
    func getPublicRepositories(completion: @escaping ([String : Any]?, Error?) -> Void) {
        switch mockResponseType {
        case .valid(let response):
            completion(response, nil)
        case .invalid(let response):
            completion(response, nil)
        case .error(let error):
            completion(nil, error)
            break
        case .none:
            break
        }
    }
}
