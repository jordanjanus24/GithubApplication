//
//  ViewController.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/2/23.
//

import UIKit
import Combine


class HomeViewController: UIViewController, Storyboarded {
    
    var coordinator: GithubApplicationCoordinatorProtocol!
    var viewModel: UsersViewModelProtocol!
    
    private var cancellables: Set<AnyCancellable> = []
    private var users = [User]()
    private var dataSource: BasicReusableTableDataSource<User>!
    private var searchText = ""
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
        }
    }
    private lazy var searchController: UISearchController = {
        var sc = UISearchController()
        sc.searchResultsUpdater = self
        sc.searchBar.placeholder = "Search"
        return sc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDataSource()
        bindView()
    }
    private func setupUI() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    private func setDataSource() {
        dataSource = BasicReusableTableDataSource(tableView, items: users, configureCell: { table, user, indexPath -> ReusableCell in
            if user.note == "" {
                if (indexPath.row + 1) % 4 == 0 {
                    let cell: InvertedViewCell = InvertedViewCell.instantiate(table, indexPath)
                    cell.configure(user)
                    return cell
                } else {
                    let cell: NormalViewCell = NormalViewCell.instantiate(table, indexPath)
                    cell.configure(user)
                    return cell
                }
            } else {
                let cell: NoteViewCell = NoteViewCell.instantiate(table, indexPath)
                cell.configure(user)
                return cell
            }
            
        }) { user,indexPath in
            if user.note == "" {
                if (indexPath.row + 1)  % 4 == 0 {
                    return InvertedViewCell.self
                } else {
                    return NormalViewCell.self
                }
            } else {
                return NoteViewCell.self
            }
        }
        tableView.dataSource = dataSource
    }
    private func bindView() {
        viewModel.fetchUsers()
        viewModel.usersPublisher
           .receive(on: DispatchQueue.main)
           .sink { [weak self] users in
               self?.setUsersData(users)
           }
           .store(in: &cancellables)
    }
    private func setUsersData(_ users: [User]) {
        self.users = users
        DispatchQueue.main.async {
            self.dataSource.reloadWithData(items: users)
        }
    }
    private func onBottomRow() {
        Reachability.isConnectedToNetwork { isConnected in
            self.viewModel.fetchUsers()
        }
    }
}
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.searchText = searchText
            if searchText != "" {
                self.dataSource.reloadWithData(items: users.filter { $0.login.contains(searchText.lowercased()) } )
            } else {
                self.dataSource.reloadWithData(items: users)
            }
        }
        
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.showDetails(self.users[indexPath.row].login)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchText == "" && indexPath.row == dataSource.count - 1 {
            onBottomRow()
        }
    }
}
