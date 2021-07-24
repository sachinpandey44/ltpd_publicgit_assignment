//
//  GithubRepository.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 24/7/21.
//

import Foundation

protocol GithubRepositoryProtocol: class {
    var githubAPIService: GithubAPIServiceProtocol { get set }
    func fetchRespositories(completion: @escaping ([RepositoryRecord]?,String?, Error?) -> Void)
}

class GithubRepository: GithubRepositoryProtocol {
    var githubAPIService: GithubAPIServiceProtocol
    
    init(apiService: GithubAPIServiceProtocol) {
        self.githubAPIService = apiService
    }
    
    func fetchRespositories(completion: @escaping ([RepositoryRecord]?, String?, Error?) -> Void) {
        print("Inside GithubRepository.getPublicRepositories()")
        githubAPIService.getPublicRepositories { (response, error) in
            guard let response = response, let repositories = response["values"] else {
                if let error = error {
                    completion(nil, nil, error)
                    return
                }
                completion(nil, nil, APIServiceErrors.genericError)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .secondsSince1970
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: repositories, options: .fragmentsAllowed)
                let repositoryRecords = try jsonDecoder.decode([RepositoryRecord].self, from: jsonData)
                print("repositoryRecords:\(repositoryRecords)")
                completion(repositoryRecords, response["next"] as? String, nil)
            } catch {
                print(error)
                completion(nil, nil, APIServiceErrors.parsingError)
                return
            }
        }
    }
}
