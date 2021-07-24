//
//  GithubRepository.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 24/7/21.
//

import Foundation

protocol GithubRepositoryProtocol: class {
    var githubAPIService: GithubAPIServiceProtocol { get set }
    func fetchRespositories(completion: @escaping ([RepositoryRecord]?, Error?) -> Void)
}

class GithubRepository: GithubRepositoryProtocol {
    var githubAPIService: GithubAPIServiceProtocol
    
    init(apiService: GithubAPIServiceProtocol) {
        self.githubAPIService = apiService
    }
    
    func fetchRespositories(completion: @escaping ([RepositoryRecord]?, Error?) -> Void) {
        print("Inside GithubRepository.getPublicRepositories()")
        githubAPIService.getPublicRepositories { (response, error) in
            guard let response = response, let repositories = response["values"] else {
                if let error = error {
                    completion(nil, error)
                }
                completion(nil, APIServiceErrors.genericError)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .secondsSince1970
            guard let jsonData = try? JSONSerialization.data(withJSONObject: repositories, options: .fragmentsAllowed),
                  let repositoryRecords = try? jsonDecoder.decode([RepositoryRecord].self, from: jsonData) else {
                completion(nil, APIServiceErrors.parsingError)
                return
            }
            print("repositoryRecords:\(repositoryRecords)")
            completion(repositoryRecords, nil)
        }
    }
}
