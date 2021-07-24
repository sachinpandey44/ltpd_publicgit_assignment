//
//  RepositoryRecord.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 23/7/21.
//

import Foundation

struct RepositoryRecord: Codable {
    var displayName: String
    var type: String
    var dateOfCreation: String
    var owner: Owner
    enum CodingKeys: String, CodingKey {
        case displayName = "full_name"
        case type = "type"
        case dateOfCreation = "created_on"
        case owner = "owner"
    }
}

struct Owner: Codable {
    var displayName: String
    var links: [String: [String: String]]
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case links = "links"
    }
    func getAvatarURL() -> String? {
        guard let avatar = links["avatar"],
              let url = avatar["href"] else {
            return nil
        }
        return url
    }
}
