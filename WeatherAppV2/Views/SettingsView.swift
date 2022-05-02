//
//  SettingsView.swift
//  WeatherAppV2
//
//  Created by dan4 on 01.05.2022.
//

import UIKit
import SnapKit

class SettingsView: UIViewController {
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(button.tintColor, for: .normal)
        button.addTarget(self, action: #selector(stepToCitiesList), for: .touchUpInside)
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        addConstraints()
    }
    
    private func addConstraints() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(45)
            make.left.equalToSuperview().inset(20)
        }
    }
    
    @objc private func stepToCitiesList() {
        dismiss(animated: true)
    }
}
