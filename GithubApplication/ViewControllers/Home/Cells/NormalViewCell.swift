//
//  UserViewCell.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import UIKit

class NormalViewCell: UITableViewCell, ReusableCell, UserViewCell {
    
    static var cellHeight: CGFloat = 70
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var details: UILabel!
    func configure(_ user: User) {
        username.text = user.login.capitalizedSentence
        details.text = user.type
        userProfile.loadFrom(user.avatarUrl, placeHolder: Cells.iconPlaceholder)
        if user.seen == true {
            self.backgroundColor = .systemGray6
        }
        else {
            self.backgroundColor = .systemBackground
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = UIView.init(frame: self.bounds)
        view.backgroundColor = .secondarySystemBackground
        self.selectedBackgroundView = view
        userProfile.image = nil
        userProfile.tintColor = UIColor.systemGray4
        userProfile.layer.cornerRadius = (userProfile.frame.size.width) / 2
        userProfile.clipsToBounds = true
        userProfile.layer.borderWidth = 1.0
        userProfile.layer.borderColor = UIColor.systemBackground.cgColor
        userProfile.layer.backgroundColor = UIColor.systemGray6.cgColor
        self.separatorInset.left = 90
    }
}
