//
//  ViewController.swift
//  OpenWeather
//
//  Created by Pablo Rodriguez on 13/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import UIKit
import RxSwift

private let cellIdentifier = "WeatherConditionsCell"

class WeatherViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: WeatherViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.outputs.title
        initTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        initContainerView()
    }
    
    /// Initializes the table view which contain the weather data
    private func initTableView() {
        let weatherConditionsCellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(weatherConditionsCellNib, forCellReuseIdentifier: cellIdentifier)
        
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    /// Initializes the container view which contain table view
    private func initContainerView() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = .zero
    }
}

// MARK: - UITableViewDataSource

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputs.rows.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WeatherConditionsCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.outputs.rows.value[indexPath.row]
        return cell
    }
}

// MARK: - Data Bindings

extension WeatherViewController {
    
    func bindViewModel() {
        viewModel.outputs.rows.asObservable().subscribe(onNext: { _ in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}

