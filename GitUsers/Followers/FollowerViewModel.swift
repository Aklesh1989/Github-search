//
//  FollowerViewModel.swift
//  GitUsers
//
//  Created by Aklesh on 13/09/22.
//

import Foundation

enum ModelType {
    case follower
    case following
}
class FollowerViewModel {
    var userList:[User] = []
    var showLoader: Notifier<Bool?> = Notifier(nil)
    var userFetched:(()-> Void)?
    var userFetchedWithError:((String)-> Void)?



    func getUserList(user:String, modelType:ModelType) {
        self.showLoader.value = true
        var requsetType:RequestItemsType
        if modelType == .following {
            requsetType = RequestItemsType.getFollowings(user)
        } else {
            requsetType = RequestItemsType.getFollowers(user)
        }
        APIManager.shared.call(type: requsetType) { (res: Result<[User], AlertMessage>) in
            self.showLoader.value = false
            switch res {
            case .success(let userResponse):
                    self.userList = userResponse
                self.userFetched?()
                break
            case .failure(let message):
                self.userFetchedWithError?(message.body)
                break
            }
            
        }
    }
}
