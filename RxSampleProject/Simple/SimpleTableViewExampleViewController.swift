//
//  SimpleTableViewExampleViewController.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimpleTableViewExampleViewController: BaseViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = 60
        tableView.separatorColor = .none
        return tableView
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let items = Observable.just(
            (0..<20).map{ "\($0)"}
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){ (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)
        
        Observable.zip(
            tableView.rx.itemSelected,
            tableView.rx.modelSelected(String.self)
        )
        .subscribe(with: self, onNext: { owner, value in
            owner.showAlert(title: "결과", message: "\(value)") {
                
            }
        })
        .disposed(by: disposeBag)
         
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(with: self) { owner, value in
                owner.showAlert(title: "악세서리 클릭", message: "\(value)") {
                    
                }
            }
            .disposed(by: disposeBag)

    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
    }
}
