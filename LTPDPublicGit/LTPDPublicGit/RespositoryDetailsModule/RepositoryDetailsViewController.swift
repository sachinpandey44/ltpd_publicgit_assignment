//
//  RepositoryDetailsViewController.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 24/7/21.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    var detailsViewModel: RepositoryDetailsViewModel!
    @IBOutlet weak var detailsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if detailsViewModel == nil {
            fatalError("View model not passed")
        }
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        guard let jsonData = try? jsonEncoder.encode(detailsViewModel.record),
              let json = String(data: jsonData, encoding: .utf8) else {
            return
        }
        detailsLabel.text = json
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
