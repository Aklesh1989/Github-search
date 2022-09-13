//
//  File2.swift
//  GitUsers
//
//  Created by Aklesh on 12/09/22.
//

import Foundation
import UIKit

class SearchUserViewController: UIViewController {
    
    @IBOutlet weak var tableViewUserList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultLabel: UILabel!


    var viewModel = SearchUserViewModel()
    var debouncedUpdateUser: Debouncer!
    var currentSelectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
            debouncedUpdateUser = Debouncer(delay: 0.3) { [weak self] in
                let searchText = self?.searchBar.text ?? ""
                self?.viewModel.searchUser(user: searchText)
            }
            prepareView()

    }
    
    // MARK: - Private methods
    
    private func bindUI() {
        
        self.viewModel.showLoader.bind { [weak self] shouldShow in
            self?.shouldHideLoader(isHidden: shouldShow ?? false)
        }
        
        self.viewModel.searchResultFetchedWithError = { [weak self] errorMessage in
            self?.showAlertWith(message: AlertMessage(title: "Error", body: errorMessage))

        }
        
        self.viewModel.searchResultFetched = { [weak self] in
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
        if viewModel.searchResult.count > 0 {
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

//MARK:- SearchBar Delegate
extension SearchUserViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let _ = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            debouncedUpdateUser.call()
        }
        print("searchText \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}

//MARK:- TableView Delegate And DataSource

extension SearchUserViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserListCell.nameOfClass, for: indexPath) as! UserListCell
        let user = viewModel.searchResult[indexPath.row]
        cell.user = user
        cell.selectionStyle = .none
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let user = viewModel.searchResult[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: UserDetailViewController.nameOfClass) as! UserDetailViewController
        vc.userName = user.name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
