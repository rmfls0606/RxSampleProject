//
//  HomeworkViewController.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/20/25.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeworkViewController: BaseViewController {

    private let tableView: UITableView = {
        let view = UITableView()
        view.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        view.backgroundColor = .systemGreen
        view.rowHeight = 100
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout())
        view.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        view.backgroundColor = .lightGray
        return view
    }()
    
    let searchBar = UISearchBar()
    
    override func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
        
        navigationItem.titleView = searchBar
    }

    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
