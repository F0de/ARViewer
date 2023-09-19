//
//  ModelCell.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 18.09.2023.
//

import UIKit
import SnapKit

class ModelCell: UICollectionViewCell, SelfConfiguringCell {
    //MARK: - Public Properties
    static let reuseIdentifier = "ModelCell"
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override methods
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if traitCollection.userInterfaceStyle == .light {
                nameLabel.textColor = .black
                selectModelButton.titleLabel?.textColor = .black
            } else {
                nameLabel.textColor = .white
                selectModelButton.titleLabel?.textColor = .white
            }
        }
    }
    
    //MARK: - Private Properties
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FixelText-Medium", size: 18)
        let currentTraitCollection = UITraitCollection.current
        if currentTraitCollection.userInterfaceStyle == .light {
            label.textColor = .black
        } else {
            label.textColor = .white
        }
        return label
    }()
    
    private lazy var selectModelButton: UIButton = {
       let button = UIButton()
        button.setTitle("Select", for: .normal)
        let currentTraitCollection = UITraitCollection.current
        if currentTraitCollection.userInterfaceStyle == .light {
            button.titleLabel?.textColor = .black
        } else {
            button.titleLabel?.textColor = .white
        }
        button.backgroundColor = .systemYellow
        
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .separator
        return separator
    }()
    
    //MARK: - Update Content
    func configure(with modelType: Model) {
        nameLabel.text = modelType.name
    }
    
    //MARK: - Setting Views
    private func setupView() {
        addSubviews()
        
        setupLayout()
    }
    
    //MARK: - Actions
    @objc func selectButtonTapped() {
        //TODO: selecting model
    }
    
    //MARK: - Setting
    private func addSubviews() {
        addSubview(nameLabel)
        addSubview(separator)
    }
    
    //MARK: - Layout
    private func setupLayout() {
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(30)
        }
        
        selectModelButton.snp.makeConstraints { make in
            make.right.equalTo(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(39)
            make.width.equalTo(89)
        }
        
        separator.snp.makeConstraints { make in
            make.height.equalTo(1/UIScreen.main.scale)
            make.bottom.left.right.equalToSuperview()
        }
        
    }
}
