//
//  MainViewController.swift
//  TodayWeather
//
//  Created by Elano on 24/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private let tableView: UITableView = {
       
        let newTableView = UITableView(frame: .zero)
        
        newTableView.register(nibNameAndIdentifier: DetailTableViewCell.identifier)
        newTableView.backgroundColor = .blue
        newTableView.rowHeight = UITableView.automaticDimension
        newTableView.estimatedRowHeight = 44
        
        return newTableView
    }()
    
    private let viewModel = MainViewModel()
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        setupTableView()
    }
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.safeAreaLayoutGuide.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return detailCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
}

// MARK: - Table Cells
private extension MainViewController {
    
    func detailCell(tableView: UITableView, indexPath: IndexPath) -> DetailTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
        
        let detail = viewModel.detail(for: indexPath)
        
        cell.nameLabel.text = detail.title
        cell.informationLabel.text = detail.information
        
        return cell
    }
}
