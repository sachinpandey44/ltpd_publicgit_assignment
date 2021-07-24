//
//  GithubAPIService.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 23/7/21.
//

import Foundation

struct BaseURL {
    static let getPublicRepositories = "https://api.bitbucket.org/2.0/repositories"
}

enum APIServiceErrors: Error {
    case genericError
    case parsingError
}

protocol GithubAPIServiceProtocol: class {
    func getPublicRepositories(completion: @escaping ([String: Any]?, Error?) -> Void)
}

class GithubAPIService: GithubAPIServiceProtocol {
    func getPublicRepositories(completion: @escaping ([String: Any]?, Error?) -> Void){
        print("Inside GithubAPIService.getPublicRepositories()")
        guard let url = URL(string: BaseURL.getPublicRepositories) else {
            completion(nil, APIServiceErrors.genericError)
            return
        }
        URLSession.shared.dataTask(with: url) { (responseData, urlResponse, error) in
            guard let responseData = responseData else {
                if let error = error {
                    completion(nil, error)
                }
                completion(nil, APIServiceErrors.genericError)
                return
            }
            guard let jsonResponse = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any] else {
                completion(nil, APIServiceErrors.genericError)
                return
            }
            print(jsonResponse)
            completion(jsonResponse, nil)
        }.resume()
    }
}
