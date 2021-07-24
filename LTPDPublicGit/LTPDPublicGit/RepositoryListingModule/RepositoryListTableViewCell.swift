//
//  RepositoryListTableViewCell.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 23/7/21.
//

import UIKit

class RepositoryListTableViewCell: UITableViewCell {
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoTypeLabel: UILabel!
    @IBOutlet weak var repoDOCLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setImage(url: String?) {
        
    }
}
