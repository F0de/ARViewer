//
//  ModelTypeCell.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 17.09.2023.
//

import UIKit
import SnapKit

class FolderCell: UICollectionViewCell, SelfConfiguringCell {
    //MARK: - Public Properties
    static let reuseIdentifier = "ModelTypeCell"

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
            } else {
                nameLabel.textColor = .white
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
    
    private lazy var navButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .systemGray
        
        button.addTarget(self, action: #selector(navButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .separator
        return separator
    }()
    
    //MARK: Update Content
    func configure(with modelType: Folder) {
        nameLabel.text = modelType.name
    }
    
    //MARK: - Setting Views
    private func setupView() {
        addSubviews()
        
        setupLayout()
    }
    
    //MARK: - Actions
    @objc func navButtonTapped() {
        //TODO: navigation to next screen
    }
    
    //MARK: - Setting
    private func addSubviews() {
        
        addSubview(navButton)
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
        
        navButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        separator.snp.makeConstraints { make in
            make.height.equalTo(1/UIScreen.main.scale)
            make.bottom.left.right.equalToSuperview()
        }
    }
}
