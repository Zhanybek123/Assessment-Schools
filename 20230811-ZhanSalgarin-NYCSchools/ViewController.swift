//
//  ViewController.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by zhanybek salgarin on 8/11/23.
//

import UIKit

protocol TableViewSelectDelegate: AnyObject {
    func didSelect(with schoolDBN: String)
}

class ViewController: UIViewController {
    
    var viewModel: CountryViewModelProtocol
    var tableViewDelegate: TableViewSelectDelegate?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemCyan
        table.register(SchoolTableViewCell.self, forCellReuseIdentifier: SchoolTableViewCell.id)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(viewModel: CountryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        configureTableView()
        
        tableViewDelegate = self
        
        title = "Schools"
        
        viewModel.didDataLoad = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.didErrorOccur = { error in
            //  MARK: Handle error properly via alert controller or pop off view
        }
    
        viewModel.fetchData()
        
        setupSearchController()
    }
    
    func configureTableView() {
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    // A sprincle of glitter :)
    func animateCell(duration: Double, indexPath: IndexPath, cell: UITableViewCell) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0.001 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            })
    }
    
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search school name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func displaySchoolView() {
        guard let schoolScore = viewModel.schoolScore.first else { return }
        let viewController = SchoolDetailViewController()
        viewController.configure(with: schoolScore)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SchoolTableViewCell.id, for: indexPath) as? SchoolTableViewCell
        let countryRow = viewModel.schools[indexPath.row]
        cell?.configure(with: countryRow)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        animateCell(duration: 0, indexPath: indexPath, cell: cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewDelegate?.didSelect(with: viewModel.schools[indexPath.row].dbn)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let _ = searchController.searchBar.text {
            // MARK: I would Implement search controller.
        }
    }
}

extension ViewController: TableViewSelectDelegate {
    func didSelect(with schoolDBN: String) {
        viewModel.fetchScoreData(schoolDBN: schoolDBN)
        viewModel.didDataLoad = { [weak self] in
            self?.displaySchoolView()
        }
    }
}
