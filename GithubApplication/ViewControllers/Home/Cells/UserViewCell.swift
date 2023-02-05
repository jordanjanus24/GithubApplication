//
//  UserViewCell.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/5/23.
//

import Foundation
import UIKit

protocol UserViewCell: ReusableCell {
    func configure(_ user: User)
}

class Cells {
    static func instantiate(_ table: UITableView, _ user: User, indexPath: IndexPath) -> UserViewCell {
        if user.note == "" {
            if (indexPath.row + 1) % 4 == 0 {
                let cell: InvertedViewCell = InvertedViewCell.instantiate(table, indexPath)
                return cell
            } else {
                let cell: NormalViewCell = NormalViewCell.instantiate(table, indexPath)
                return cell
            }
        } else {
            if (indexPath.row + 1) % 4 == 0 {
                let cell: InvertedNoteViewCell = InvertedNoteViewCell.instantiate(table, indexPath)
                return cell
            } else {
                let cell: NoteViewCell = NoteViewCell.instantiate(table, indexPath)
                return cell
            }
        }
    }
    static func heightForRow(_ user: User, indexPath: IndexPath) -> CGFloat{
        if user.note == "" {
            if (indexPath.row + 1) % 4 == 0 {
                return InvertedViewCell.self.cellHeight
            } else {
                return NormalViewCell.self.cellHeight
            }
        } else {
            if (indexPath.row + 1) % 4 == 0 {
                return InvertedNoteViewCell.self.cellHeight
            } else {
                return NoteViewCell.self.cellHeight
            }
        }
    }
}
