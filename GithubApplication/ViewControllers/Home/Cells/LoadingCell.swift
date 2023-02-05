//
//  LoadingCell.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/5/23.
//

import Foundation
import UIKit

protocol LoadingCellProtocol {
    func start()
}

class LoadingCell: UITableViewCell, ReusableCell, LoadingCellProtocol {
    static var cellHeight: CGFloat = 80
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override class func awakeFromNib() {
        self.awakeFromNib()
    }
    func start() {
        activityIndicator.startAnimating()
    }
}
