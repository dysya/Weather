//
//  ViewController.swift
//  WeatherAppV2
//
//  Created by dan4 on 01.05.2022.
//

import UIKit
import SnapKit

class CitiesListView: UIViewController {
    
    // MARK: Parametres
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        return button
    }()
    
    private lazy var cityField: UITextField = {
        let field = UITextField()
        field.placeholder = "City name..."
        field.borderStyle = .roundedRect
        return field
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addCity), for: .touchUpInside)
        return button
    }()
    
    private var viewModel: WeatherViewModel = WeatherViewModel()
    var tableView = UITableView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        cityField.delegate = self
        
        addConstraints()
        setupBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.cities.removeAll()
        tableView.reloadData()
    }
    
    // MARK: Binding
    func setupBinding() {
        viewModel.weatherData.bind { [weak self] data in
            /// Этот метод срабатывает каждый раз, когда обновляется переменная weatherData
            guard let data = data, let self = self else { return }
            DispatchQueue.main.async {
                /// Тут можешь обновлять таблицу с помощью data
                self.viewModel.cities.append(
                    City(
                        name: data.name,
                        temperature: data.main.temp
                    )
                )
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Add constraints
    func addConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(135)
            make.left.right.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().inset(0)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(45)
        }
        
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(50)
        }
        
        view.addSubview(cityField)
        cityField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(56.5)
            make.top.equalTo(nameLabel).inset(40)
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel).inset(45)
            make.right.equalToSuperview().inset(21.5)
        }
    }
    
    @objc private func addCity() {
        viewModel.weatherByCity(name: cityField.text ?? "")
        cityField.resignFirstResponder()
        cityField.text?.removeAll()
    }
    
}

// MARK: UITextFieldDelegate
extension CitiesListView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addCity()
        return true
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CitiesListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = viewModel.cities[indexPath.row]
        cell.textLabel?.text = city.name + " \(city.temperature)F"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = DetailView()
        controller.city =  viewModel.cities[indexPath.row]
        present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

