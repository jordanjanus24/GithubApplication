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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDataSource()
        bindView()
    }
    private func setupUI() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    private func setDataSource() {
        dataSource = BasicReusableTableDataSource(tableView, items: users) { table, user, indexPath -> ReusableCell in
            let cell: UserViewCell = Cells.instantiate(table, user, indexPath: indexPath)
            cell.configure(user)
            return cell
        }
        tableView.dataSource = dataSource
    }
    private func bindView() {
        viewModel.lastRequested = 0
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Cells.heightForRow(self.users[indexPath.row], indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.showDetails(self.users[indexPath.row].login)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchText == "" && indexPath.row == dataSource.count - 1 {
            onBottomRow()
        }
    }
}
