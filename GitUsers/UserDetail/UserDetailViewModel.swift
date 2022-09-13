//
//  UserDetailViewModel.swift
//  GitUsers
//
//  Created by Aklesh on 13/09/22.
//

import Foundation
import UIKit

class UserDetailViewModel {
    var user:UserDetail?
    var showLoader: Notifier<Bool?> = Notifier(nil)
    var userFetched:(()-> Void)?
    var userFetchedWithError:((String)-> Void)?
    var imageDownLoaded:((UIImage)-> Void)?




    func getUser(user:String) {
        self.showLoader.value = true
        APIManager.shared.call(type: RequestItemsType.getUser(user)) { (res: Result<UserDetail, AlertMessage>) in
            self.showLoader.value = false
            switch res {
            case .success(let userResponse):
                self.user = userResponse
                self.downloadUserImage()
                self.userFetched?()
                break
            case .failure(let message):
                self.userFetchedWithError?(message.body)
                break
            }
            
        }
    }
    
    func downloadUserImage()  {
        if let imgUrl = user?.imageUrl, !imgUrl.isEmpty {
            print("image url is \(imgUrl)")
            APIManager.shared.downloadImage(from: imgUrl) { (image) in
                print("downloadImage done")
                if let imageFound = image {
                    self.imageDownLoaded?(imageFound)
                }
            }
        }
    }
}


