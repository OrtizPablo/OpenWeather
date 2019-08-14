//
//  WeatherConditionsCell.swift
//  OpenWeather
//
//  Created by Pablo Rodriguez on 14/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import UIKit

final class WeatherConditionsCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var conditionsImageView: UIImageView!
    
    var viewModel: WeatherConditionsCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Private methods
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        conditionsImageView.isHidden = !viewModel.outputs.shouldShowImage
        titleLabel.text = viewModel.outputs.title
        conditionsLabel.text = viewModel.outputs.conditionText
        conditionsImageView.image = viewModel.outputs.image
    }
}
