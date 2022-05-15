//
//  CurrentLocationWeather.swift
//  WeatherAppV2
//
//  Created by dan4 on 05.05.2022.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation


class CurrentLocationWeather: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Parametrs
    let locationManager = CLLocationManager()
    
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
        label.text = "54℉"
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private lazy var visibilityLabel: UILabel = {
        let label = UILabel()
        label.text = "1000 miles"
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private lazy var weatherType: UILabel = {
        let label = UILabel()
        label.text = "Sunny"
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "sun.max.fill"))
        image.tintColor = .orange
        return image
    }()
    
    private lazy var coordinatesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private var viewModel: WeatherViewModel = WeatherViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        makeConstraints()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        setupBinding()
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = manager.location else { return }
        fetchCityAndCountry(from: location) { [self] city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            print(city + ", " + country)
            self.cityName.text = "\(city)"
            self.viewModel.weatherByCity(name: city)
            tempLabel.text = "\(viewModel.weatherData.value?.main.temp ?? 0)℉"
            visibilityLabel.text = "\(viewModel.weatherData.value?.visibility ?? 0) miles"
        }
    }
    
    func setupBinding() {
        
        viewModel.weatherData.bind { [weak self] data in
            guard let data = data, let self = self else { return }
            DispatchQueue.main.async {
                self.viewModel.cities.append(
                    City(
                        name: data.name,
                        temperature: data.main.temp,
                        visibility: data.visibility
                    )
                )
                
            }
        }
    
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
            make.top.equalTo(nameLabel).inset(100)
            make.centerX.equalTo(view.center.x)
        }
        
        view.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityName).inset(35)
            make.centerX.equalTo(view.center.x)
        }
        
        view.addSubview(visibilityLabel)
        visibilityLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel).inset(35)
            make.centerX.equalTo(view.center.x)
        }
        
        view.addSubview(weatherType)
        weatherType.snp.makeConstraints { make in
            make.top.equalTo(visibilityLabel).inset(35)
            make.centerX.equalTo(view.center.x)
        }
        
        view.addSubview(weatherImage)
        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(weatherType).inset(35)
            make.centerX.equalTo(view.center.x)
        }
        
        view.addSubview(coordinatesLabel)
        coordinatesLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImage).inset(35)
            make.centerX.equalTo(view.center.x)
        }
        
    }
    
    // MARK: - Steps to other view controllers
    @objc private func stepToSettings() {
        let settingsVC = SettingsView()
        settingsVC.modalPresentationStyle = .fullScreen
        present(settingsVC, animated: true)
    }
    
    @objc private func stepToListVC() {
        let listVC = CitiesListView()
        listVC.modalPresentationStyle = .fullScreen
        present(listVC, animated: true)
    }
    
}
