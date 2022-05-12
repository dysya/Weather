//
//  CurrentLocationWeather.swift
//  WeatherAppV2
//
//  Created by dan4 on 05.05.2022.
//

import UIKit
import SnapKit

class CurrentLocationWeather: UIViewController {
    
    // MARK: - Parametrs
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather app"
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.addTarget(self, action: #selector(stepToSettings), for: .touchUpInside)
        return button
    }()
    
    private lazy var cityName: UILabel = {
        let label = UILabel()
        label.text = "London"
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.text = "54F"
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "sun.max.fill"))
        image.tintColor = .orange
        return image
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        makeConstraints()
    }
    
    // MARK: - Add constraints
    private func makeConstraints() {
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(45)
            make.left.equalToSuperview().inset(20)
        }
    
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.right.equalToSuperview().inset(20)
        }
    
        view.addSubview(cityName)
        cityName.snp.makeConstraints { make in
            make.top.equalTo(nameLabel).inset(60)
            make.centerX.equalTo(view.center.x)
        }
        
        view.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityName).inset(35)
            make.centerX.equalTo(view.center.x)
        }
        
        view.addSubview(weatherImage)
        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(tempLabel).inset(35)
            make.centerX.equalTo(view.center.x)
        }
        
        
    }
    
    // MARK: - Steps to other view controllers
    @objc private func stepToSettings() {
        let settingsVC = SettingsView()
        settingsVC.modalPresentationStyle = .fullScreen
        present(settingsVC, animated: true)
    }
    
}
