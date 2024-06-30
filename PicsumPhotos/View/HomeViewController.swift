//
//  ViewController.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var viewModel = PhotoListViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        viewModel.fetchPhotos()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshPhotos), for: .valueChanged)
    }
    
    /// Binds the ViewModel to the view, setting up closures to handle data updates and errors.
    private func bindViewModel() {
        viewModel.photosDidUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.errorHandler = { error in
            print("Error fetching photos: \(error)")
        }
    }
    
    /// Refreshes the photo list when the refresh control is triggered.
    @objc private func refreshPhotos() {
        viewModel.refreshPhotos()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        
        if let photo = viewModel.photo(at: indexPath.row) {
            cell.configure(with: photo, isSelected: viewModel.isCheckboxSelected(for: photo.id))
            cell.checkboxAction = { [weak self] isSelected in
                self?.viewModel.setCheckboxState(for: photo.id, isSelected: isSelected)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photo = viewModel.photo(at: indexPath.row) else { return }
        let cell = tableView.cellForRow(at: indexPath) as! PhotoTableViewCell
        
        if cell.isCheckboxChecked {
            let alert = UIAlertController(title: "Description", message: photo.url, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Checkbox is not checked", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            viewModel.fetchPhotos()
        }
    }
}
