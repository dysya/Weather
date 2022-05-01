//
//  DetailView.swift
//  WeatherAppV2
//
//  Created by dan4 on 01.05.2022.
//

import UIKit
import SnapKit

class DetailView: UIViewController {
    private var cityNameLabel = UILabel()
    var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        initialize()
        
    }
    
    func initialize() {
        view.addSubview(cityNameLabel)
        cityNameLabel.text = city.name + " " + "\(city.temperature)" + "F"
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.equalToSuperview().inset(20)
        }
        
    }
}
