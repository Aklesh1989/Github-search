//
//  File3.swift
//  GitUsers
//
//  Created by Aklesh on 12/09/22.
//

import Foundation

class SearchUserViewModel {
    var searchResult:[User] = []
    var showLoader: Notifier<Bool?> = Notifier(nil)
    var searchResultFetched:(()-> Void)?
    var searchResultFetchedWithError:((String)-> Void)?



    func searchUser(user:String) {
        self.showLoader.value = true
        self.searchResult.removeAll()
        APIManager.shared.call(type: RequestItemsType.searchUser(user)) { (res: Result<UserResponse, AlertMessage>) in
            self.showLoader.value = false
            switch res {
            case .success(let userResponse):
                if let users = userResponse.items {
                    self.searchResult = users
                }
                self.searchResultFetched?()
                break
            case .failure(let message):
                self.searchResultFetchedWithError?(message.body)
                break
            }
            
        }
    }
}



