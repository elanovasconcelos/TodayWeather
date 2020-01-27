//
//  MainViewController.swift
//  TodayWeather
//
//  Created by Elano on 24/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    private let tableView: UITableView = {
       
        let newTableView = UITableView(frame: .zero)
        
        newTableView.register(nibNameAndIdentifier: DetailTableViewCell.identifier)
        newTableView.register(nibNameAndIdentifier: WeatherImageTableViewCell.identifier)

        newTableView.rowHeight = UITableView.automaticDimension
        newTableView.estimatedRowHeight = 44
        
        return newTableView
    }()
    
    private var viewModel: MainViewModel { didSet{ reloadTable() } }
    private var locationModel: LocationModel
    
    //MARK: -
    init(viewModel: MainViewModel = MainViewModel(), locationModel: LocationModel = LocationModel()) {
        self.viewModel = viewModel
        self.locationModel = locationModel

        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
        self.locationModel.delegate = self
        self.view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        
        self.viewModel = MainViewModel()
        self.locationModel = LocationModel()
        
        super.init(coder: coder)
    }
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        locationModel.requestWhenInUseAuthorization()
        locationModel.updateLocation()
        //TODO: add loading while getting information
    }
    
    private func setupTableView() {

        view.addSubview(tableView)
        updateTableVisibility()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.safeAreaLayoutGuide.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }

    private func updateTableVisibility() {
        tableView.isHidden = !viewModel.shouldShowRows()
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.updateTableVisibility()
            self.tableView.reloadData()
        }
    }
}

//MARK: -
extension MainViewController: LocationModelDelegate {
    func locationModel(_ model: LocationModel, didChange location: Location) {
        viewModel.update(with: location)
    }
}

//MARK: - MainViewModelDelegate
extension MainViewController: MainViewModelDelegate {
    func mainViewModelChangedData(_ model: MainViewModel) {
        reloadTable()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = TableSection(rawValue: indexPath.section) else {
            
            assertionFailure("[MainViewController] Invalid section \(indexPath.section)")
            return UITableViewCell()
        }
        
        switch section {
        case .detail: return detailCell(tableView: tableView, indexPath: indexPath)
        case .image: return weatherImageCell(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !viewModel.shouldShowRows() {
            return 0
        }
        
        guard let tableSection = TableSection(rawValue: section) else { return 0 }
        
        switch tableSection {
        case .image: return 1
        case .detail: return viewModel.detailCount
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.values().count
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
    
    func weatherImageCell(tableView: UITableView, indexPath: IndexPath) -> WeatherImageTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherImageTableViewCell.identifier, for: indexPath) as! WeatherImageTableViewCell
        
        cell.weatherImageView.image = viewModel.wheaderImage
        cell.temperatureLabel.text = viewModel.temperature
        
        return cell
    }
}

//MARK: - Enum
extension MainViewController {
    enum TableSection: Int {
        case image
        case detail
        
        /// It returns all the TableSection values. It's the section order too.
        static func values() -> [TableSection] {
            return [.image, .detail]
        }
    }
}
