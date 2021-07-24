//
//  RepositoryListTableViewController.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 23/7/21.
//

import UIKit

class RepositoryListTableViewController: UITableViewController {
    var repositoryListViewModel: RepositoryListViewModel!
    var activityIndicatorView: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = activityIndicatorView

        let apiService = GithubAPIService()
        let repository = GithubRepository(apiService: apiService)
        repositoryListViewModel = RepositoryListViewModel(repository: repository, delegate: self)
        repositoryListViewModel.didReceivedEvent(event: .viewDidLoad)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryListViewModel.rowsData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryListTableViewCell", for: indexPath) as! RepositoryListTableViewCell

        // Configure the cell...
        let currentRow =  repositoryListViewModel.rowsData[indexPath.row]
        cell.repoNameLabel.text = currentRow.displayName
        cell.repoTypeLabel.text = currentRow.type
        cell.repoDOCLabel.text = currentRow.dateOfCreation
        cell.setImage(url: currentRow.owner.getAvatarURL())
        
        if let backdropImageURL = URL(string: currentRow.owner.getAvatarURL() ?? "") {
            let movieImageSize = cell.ownerAvatarImageView.bounds.size
            let scale = tableView.traitCollection.displayScale
            DispatchQueue.global().async {
                let downloadedImage = self.downloadImage(atURL: backdropImageURL, forSize: movieImageSize, scale: scale)
                DispatchQueue.main.async {
                    cell.ownerAvatarImageView.image = downloadedImage
                }
            }
        }
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showLoading() {
        self.view.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    private func hideLoading() {
        self.view.sendSubviewToBack(activityIndicatorView)
        activityIndicatorView.stopAnimating()
    }
    
    func showAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension RepositoryListTableViewController: RepositoryListViewModelDelegate {
    func didUpdateState(state: RepositoryListViewModelState) {
        hideLoading()
        switch state {
        case .loading:
            showLoading()
        case .error(let error):
            showAlert(error: error)
        case .repositoryFetched:
            self.tableView.reloadData()
        }
    }
}
