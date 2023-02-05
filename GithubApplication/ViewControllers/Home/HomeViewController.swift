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
    
    lazy var refreshController: UIRefreshControl = {
        var refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged )
        return refreshController
    }()
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.refreshControl = refreshController
        }
    }
    @IBOutlet weak var noInternetConnectionView: UIView!
    private lazy var searchController: UISearchController = {
        var sc = UISearchController()
        sc.searchResultsUpdater = self
        sc.searchBar.placeholder = "Search"
        return sc
    }()
    
    private var isLoadingPaginated = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDataSource()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindView()
        initialData()
    }
    private func setupUI() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        noInternetConnectionView.isHidden = true
        tableView.isHidden = false
    }
    private func setDataSource() {
        dataSource = BasicReusableTableDataSource(tableView, items: users, numberOfSections: 2) { table, user, indexPath -> ReusableCell in
            if indexPath.section == 0 {
                let cell: UserViewCell = Cells.instantiate(table, user!, indexPath: indexPath)
                cell.configure(user!)
                return cell
            }
            else  {
                let cell = LoadingCell.instantiate(table, indexPath)
                cell.start()
                return cell
            }
        }
        tableView.dataSource = dataSource
    }
    private func initialData() {
        self.viewModel.lastRequested = 0
        NetworkManager.networkCallback = { [weak self] isConnected in
            self?.viewModel.fetchUsers()
        }
    }
    private func bindView() {
        viewModel.usersPublisher
           .receive(on: DispatchQueue.main)
           .sink { [weak self] users in
               if users.isEmpty == true {
                   self?.showNoConnection()
               } else {
                   if self?.fromRefreshController == true || self?.isLoadingPaginated == true{
                       DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                           self?.setUsersData(users)
                           self?.refreshController.endRefreshing()
                           self?.isLoadingPaginated = false
                           self?.dataSource.showBottomSection(show: false)
                        }
                   } else {
                       self?.setUsersData(users)
                   }
               }
           }
           .store(in: &cancellables)
    }
    private func showNoConnection() {
        if NetworkManager.isReachable == false {
            noInternetConnectionView.isHidden = false
            tableView.isHidden = true
        }
    }
    private func setUsersData(_ users: [User]) {
        self.users = users
        DispatchQueue.main.async {
            self.dataSource.reloadWithData(items: users)
        }
    }
    private func onBottomRow() {
        isLoadingPaginated = true
        if NetworkManager.isReachable == true {
            self.viewModel.fetchUsers()
        }
    }
    private var fromRefreshController = false
    @objc func refreshData(_ sender: UIRefreshControl) {
        fromRefreshController = true
        initialData()
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
        if indexPath.section == 0 {
            return Cells.heightForRow(self.users[indexPath.row], indexPath: indexPath)
        } else {
            return LoadingCell.self.cellHeight
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.showDetails(self.users[indexPath.row].login)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchText == "" && indexPath.row == dataSource.count - 10, isLoadingPaginated == false {
            onBottomRow()
            dataSource.showBottomSection(show: true)
            if indexPath.section != 0 {
                cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
            }
        }
    }
}
