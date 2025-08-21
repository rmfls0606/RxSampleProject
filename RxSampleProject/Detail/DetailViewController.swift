//
//  DetailViewController.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/22/25.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    private let name: String
    
    init(name: String){
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureView() {
        view.backgroundColor = .white
        
        navigationItem.title = name
    }
}
