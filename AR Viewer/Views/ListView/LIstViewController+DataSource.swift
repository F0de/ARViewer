//
//  LIstViewController+DataSource.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 17.09.2023.
//

import UIKit

extension ListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Folder>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Folder>
    
    func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCell.reuseIdentifier, for: indexPath) as? FolderCell else {
                fatalError("The CollectionView cold not dequeue a ModelTypeCell in ListViewController")
            }
            cell.configure(with: itemIdentifier)
            return cell
        })
    }
    
    func applySnapshot(models: [Folder]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(models)
        dataSource.apply(snapshot)
    }
}

//MARK: - Delegating
extension ListViewController: UICollectionViewDelegate {
    
}
