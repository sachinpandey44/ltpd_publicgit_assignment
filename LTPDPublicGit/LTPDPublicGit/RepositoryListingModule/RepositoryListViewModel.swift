//
//  RepositoryListViewModel.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 23/7/21.
//

import Foundation
import UIKit

enum RepositoryListViewModelState {
    case loading
    case repositoryFetched
    case error(APIServiceErrors)
}

enum RepositoryListDelegateEvent {
    case viewDidLoad
    case viewWillAppear
    case fetchNextPage
}

protocol RepositoryListViewModelDelegate: UIViewController {
    func didUpdateState(state: RepositoryListViewModelState)
}

protocol RepositoryListViewModelProtocol: class {
    var delegate: RepositoryListViewModelDelegate? { get set }
    var gitRespository: GithubRepositoryProtocol? { get set }
    var state: RepositoryListViewModelState { get set }
    var rowsData: [RepositoryRecord] { get set }
    var nextPage: String? { get set }
    func didReceivedEvent(event: RepositoryListDelegateEvent)
}

class RepositoryListViewModel: RepositoryListViewModelProtocol {
    weak var delegate: RepositoryListViewModelDelegate?
    var gitRespository: GithubRepositoryProtocol?
    var rowsData: [RepositoryRecord] = []
    var nextPage: String?
    var state: RepositoryListViewModelState = .loading {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didUpdateState(state: self.state)
            }
        }
    }
    
    init(repository: GithubRepositoryProtocol, delegate: RepositoryListViewModelDelegate) {
        self.delegate = delegate
        self.gitRespository = repository
    }
    
    func didReceivedEvent(event: RepositoryListDelegateEvent) {
        switch event {
        case .viewDidLoad:
            //Fetch the repos list
            self.state = .loading
            gitRespository?.fetchRespositories(completion: { [weak self](records, next, error) in
                guard let self = self else {
                    print("Unexpected. Self found to be nil")
                    return
                }
                guard let records = records else {
                    self.rowsData = []
                    self.state = .error(error as? APIServiceErrors ?? .genericError)
                    return
                }
                self.rowsData = records
                self.nextPage = next
                self.state = .repositoryFetched
            })
        break
        case .viewWillAppear:
            break
        case .fetchNextPage:
            //TODO: fetch next page of repos
            self.state = .error(.notImplementedError("Functionality not implemented"))
            break
        }
    }

}
