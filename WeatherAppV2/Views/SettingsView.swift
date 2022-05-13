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
    }()
    
    private lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Color theme"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var themeSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(self, action: #selector(setOn), for: .allTouchEvents)
        return switcher
    }()
    
    private var switcher = 1
    
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
    
        view.addSubview(themeLabel)
        themeLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton).inset(40)
            make.left.equalToSuperview().inset(20)
        }
        
        view.addSubview(themeSwitch)
        themeSwitch.snp.makeConstraints { make in
            make.top.equalTo(backButton).inset(35)
            make.right.equalToSuperview().inset(20)
        }
        
    }
    
    @objc private func stepToCitiesList() {
        dismiss(animated: true)
    }
    
    @objc func setOn(_ sender: UISwitch) {
        if sender.isOn {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
    }
    
}
