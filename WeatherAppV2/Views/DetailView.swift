//
//  DetailView.swift
//  WeatherAppV2
//
//  Created by dan4 on 01.05.2022.
//

import UIKit
import SnapKit

class DetailView: UIViewController {
    
    var city: City!
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = city.name + " " + "\(city.temperature)" + "℉"
        return label
    } ()
    
    private lazy var cityVisibilitey: UILabel = {
        let label = UILabel()
        label.text = "Visibility \(city.visibility) meters"
        return label
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        addConstraints()
        
    }
    
    func addConstraints() {
        
        view.addSubview(cityNameLabel)
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.equalToSuperview().inset(20)
        }
        
        view.addSubview(cityVisibilitey)
        cityVisibilitey.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel).inset(30)
            make.left.equalToSuperview().inset(20)
        }
        
    }
}
