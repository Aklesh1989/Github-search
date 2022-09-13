//
//  FollowerViewController.swift
//  GitUsers
//
//  Created by Aklesh on 13/09/22.
//

import Foundation
import UIKit
class FollowerViewController: UIViewController {
    
    @IBOutlet weak var tableViewUserList: UITableView!
    @IBOutlet weak var noResultLabel: UILabel!
    var modelType = ModelType.follower
    var user:String!
    var viewModel = FollowerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        viewModel.getUserList(user: user, modelType: modelType)
        if modelType == .follower{
            self.title = "Followers"
        } else {
            self.title = "Following"
        }

    }
    
    // MARK: - Private methods
    
    private func bindUI() {
        
        self.viewModel.showLoader.bind { [weak self] shouldShow in
            self?.shouldHideLoader(isHidden: shouldShow ?? false)
        }
        
        self.viewModel.userFetchedWithError = { [weak self] errorMessage in
            self?.showAlertWith(message: AlertMessage(title: "Error", body: errorMessage))

        }
        
        self.viewModel.userFetched = { [weak self] in
            self?.reloadTable()
        }
    }
    
    private func registerCell() {
        tableViewUserList.register(UserListCell.nib(), forCellReuseIdentifier: UserListCell.nameOfClass)

    }


    
    func prepareView() {
        registerCell()
        tableViewUserList.tableFooterView = UIView()
        self.tableViewUserList.backgroundView = self.noResultLabel
        self.noResultLabel.isHidden = true
        bindUI()
    }
    
    func reloadTable() {
        if viewModel.userList.count > 0 {
            self.noResultLabel.isHidden = true
            DispatchQueue.main.async {
                self.tableViewUserList.reloadData()
            }
        } else {
            DispatchQueue.main.async {
                self.tableViewUserList.reloadData()
                self.noResultLabel.isHidden = false

            }
        }
        
    }

}

//MARK:- TableView Delegate And DataSource

extension FollowerViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserListCell.nameOfClass, for: indexPath) as! UserListCell
        let user = viewModel.userList[indexPath.row]
        cell.user = user
        cell.selectionStyle = .none
        return cell

    }
    
    
}

