//
//  UserListCell.swift
//  GitSearch
//
//  Created by Aklesh on 12/09/22.
//

import UIKit

class UserListCell: UITableViewCell {
	
	@IBOutlet weak var imgUserPic: UIImageView!
	@IBOutlet weak var lblName: UILabel!
	var user:User! {
		didSet {
			configureDisplay()
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func nib() -> UINib{
        return UINib(nibName: UserListCell.nameOfClass, bundle:nil)
    }
	
	func configureDisplay() {
		if let userObject = user {
			lblName.text = userObject.name
			downloadUserImage()
		}
	}
	
	func downloadUserImage()  {
		if let imgUrl = user.imageUrl, !imgUrl.isEmpty {
			//print("image url is \(imgUrl)")
            APIManager.shared.downloadImage(from: imgUrl) { [weak self](image) in
				//print("downloadImage done")
				if let imageFound = image {
					DispatchQueue.main.async {
						self?.imgUserPic.image = imageFound
					}
				}
			}
		}
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
