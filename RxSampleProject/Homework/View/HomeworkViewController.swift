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

    //MARK: - Property
    private let recommendedNameList = BehaviorSubject<[String]>(value: [])
    private var personList = BehaviorSubject<[Person]>(value: Person.sampleUsers)
    
    private let disposeBag = DisposeBag()
    
    //MARK: - View
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
    
    override func configureBind() {
        recommendedNameList
            .bind(to: collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self)){ (item, element, cell) in
                cell.configureData(name: element)
            }
            .disposed(by: disposeBag)
        
        personList
            .bind(to: tableView.rx.items){ (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.identifier) as! PersonTableViewCell
                cell.configureData(person: element)
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Person.self)
            .distinctUntilChanged({ $0.name == $1.name})
            .bind(with: self) { owner, value in
                var result = try! owner.recommendedNameList.value()
                result.append(value.name)
                owner.recommendedNameList.onNext(result)
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .subscribe(with: self) { owner, value in
                guard let name = owner.searchBar.text else { return }
                
                let newValue = Person(name: name, email: "\(value)@example.com", profileImage: "")
                var result = try! owner.personList.value()
                result.append(newValue)
                
                owner.personList.onNext(result)
            }
            .disposed(by: disposeBag)

    }

    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
