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
    case error
}

enum RepositoryListDelegateEvent {
    case viewDidLoad
    case viewWillAppear
    case reachedEndOfList
}

protocol RepositoryListViewModelDelegate: UIViewController {
    func didUpdateState(state: RepositoryListViewModelState)
}

protocol RepositoryListViewModelProtocol: class {
    var delegate: RepositoryListViewModelDelegate? { get set }
    var gitRespository: GithubRepositoryProtocol? { get set }
    var state: RepositoryListViewModelState { get set }
    var sections: [RepositoryRecord] { get set }
    func didReceivedEvent(event: RepositoryListDelegateEvent)
}

class RepositoryListViewModel: RepositoryListViewModelProtocol {
    weak var delegate: RepositoryListViewModelDelegate?
    var gitRespository: GithubRepositoryProtocol?
    var sections: [RepositoryRecord] = []
    var state: RepositoryListViewModelState = .loading {
        didSet {
            delegate?.didUpdateState(state: state)
        }
    }
    
    init(repository: GithubRepositoryProtocol, delegate: RepositoryListViewModelDelegate) {
        self.delegate = delegate
        self.gitRespository = repository
    }
    
    func didReceivedEvent(event: RepositoryListDelegateEvent) {
        switch event {
        case .viewDidLoad:
            //TODO: fetch the repos list
        break
        case .viewWillAppear:
            break
        case .reachedEndOfList:
            //TODO: fetch next page of repos
            break
        }
    }

}
