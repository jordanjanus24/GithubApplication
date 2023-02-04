//
//  BaseViewCell.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import UIKit

protocol ReusableCell {
    static var reuseIdentifier: String { get }
    static var cellHeight: CGFloat { get }
    static func instantiate(_ tableView: UITableView, _ indexPath: IndexPath) -> Self
}

extension ReusableCell where Self: UITableViewCell{
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static func instantiate(_ tableView: UITableView, _ indexPath: IndexPath) -> Self {
        return tableView.dequeueReusable(Self.self, indexPath)
    }
}


protocol NibReusableCell: ReusableCell {
    static var nib: UINib? { get }
}

extension NibReusableCell {
    static var nib: UINib? {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}


extension UITableView {
    func registerReusable<T: UITableViewCell>(_: T.Type) where T: NibReusableCell {
        if let nib = T.nib {
          self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
          self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    func dequeueReusable<T: UITableViewCell>(_: T.Type, _ indexPath: IndexPath) -> T where T: NibReusableCell {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusable<T: UITableViewCell>(_: T.Type, _ indexPath: IndexPath) -> T where T: ReusableCell {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
