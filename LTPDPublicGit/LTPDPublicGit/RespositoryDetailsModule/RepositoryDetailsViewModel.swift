//
//  RepositoryDetailsViewModel.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 24/7/21.
//

import Foundation
import UIKit

protocol RepositoryDetailsViewModelProtocol: class {
    var record: RepositoryRecord { get set }
}

class RepositoryDetailsViewModel: RepositoryDetailsViewModelProtocol {
    var record: RepositoryRecord
    init(record: RepositoryRecord) {
        self.record = record
    }
}
