//
//  RepositoryListTableViewController.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 23/7/21.
//

import UIKit

class RepositoryListTableViewController: UITableViewController {
    var repositoryListViewModel: RepositoryListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiService = GithubAPIService()
        let repository = GithubRepository(apiService: apiService)
        repositoryListViewModel = RepositoryListViewModel(repository: repository, delegate: self)
        repositoryListViewModel.didReceivedEvent(event: .viewDidLoad)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showLoading() {
        
    }
    
    func showAlert(error: Error) {
        
    }
    
}

extension RepositoryListTableViewController: RepositoryListViewModelDelegate {
    func didUpdateState(state: RepositoryListViewModelState) {
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
