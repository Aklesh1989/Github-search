//
//  UserDetailViewController.swift
//  GitUsers
//
//  Created by Aklesh on 13/09/22.
//

import Foundation
import UIKit

class UserDetailViewController: UIViewController {
    

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var imgUserPic: UIImageView!
    @IBOutlet weak var btnFollower: UIButton!
    @IBOutlet weak var btnFollowing: UIButton!

    var userName:String!
    var viewModel = UserDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        viewModel.getUser(user: userName)
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
            self?.displayUserDetails()
        }
        
        self.viewModel.imageDownLoaded = { [weak self] image in
            DispatchQueue.main.async {
                self?.imgUserPic.image = image
            }
        }
        
    }
    

    private func displayUserDetails() {
        viewModel.downloadUserImage()
        lblUserName.text = "Name: \(viewModel.user?.name ?? userName!)"
        userEmail.text = "Email: \(viewModel.user?.email ?? "No email id found.")"
        
        let following = getFolloweingCount()
        btnFollowing.setTitle(following, for: .normal)
        
        let follower = getFollowerCount()
        btnFollower.setTitle(follower, for: .normal)
    }
    
    func getFollowerCount() -> String  {
        var stringToReturn = "Follower: 0"
        if let count = viewModel.user?.followers {
            stringToReturn = "Followers: \(count) "
        }
        return stringToReturn
    }
    
    func getFolloweingCount() -> String  {
        var stringToReturn = "Following: 0"
        if let count = viewModel.user?.following {
            stringToReturn = "Following: \(count)"
        }
        return stringToReturn
    }
    
    func navigateToListView(modelType:ModelType) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: FollowerViewController.nameOfClass) as! FollowerViewController
        vc.user = self.userName
        vc.modelType = modelType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnFollowerClicked(_ sender: UIButton) {
        if let count = viewModel.user?.followers, count > 0 {
            self.navigateToListView(modelType: .follower)
        } else {
            self.showAlertWith(message: AlertMessage(title: "", body: "No followers available"))
        }
        
    }
    
    @IBAction func btnFollowingClicked(_ sender: UIButton) {
        if let count = viewModel.user?.following, count > 0 {
            self.navigateToListView(modelType: .following)
        } else {
            self.showAlertWith(message: AlertMessage(title: "", body: "No following available"))
        }
    }
    

}
