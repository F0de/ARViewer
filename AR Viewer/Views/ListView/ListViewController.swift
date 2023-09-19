//
//  ListViewController.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 17.09.2023.
//

import UIKit

class ListViewController: UIViewController {
    //MARK: - Properties
    
    
    enum Section {
        case main
    }
    lazy var collectionView = UICollectionView()
    var dataSource: DataSource!
    var snapshot = DataSourceSnapshot()
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    //MARK: - Setup Views Methods
    
    //MARK: - Setup CollectionView
    private func createLayout() -> UICollectionViewLayout {
        let modelTypeCellSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(69))
        let modelTypeCell = NSCollectionLayoutItem(layoutSize: modelTypeCellSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [modelTypeCell])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureCollectionViewLayout() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.register(FolderCell.self, forCellWithReuseIdentifier: FolderCell.reuseIdentifier)
        collectionView.register(ModelCell.self, forCellWithReuseIdentifier: ModelCell.reuseIdentifier)
    }
    
    //MARK: - Setting Views
    func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "3D Models"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionViewLayout()
        configureCollectionViewDataSource()
        applySnapshot(models: Folder.folders)
        
        addSubViews()
        
        setupLayout()

    }
    //MARK: - Setting
    func addSubViews() {
        view.addSubview(collectionView)
    }
    //MARK: - Layout
    func setupLayout() {
        
        
    }
}
