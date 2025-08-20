//
//  UserCollectionViewCell.swift
//  iOSAcademy-RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import SnapKit

final class UserCollectionViewCell: BaseCollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(label)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    func configureData(name: String){
        label.text = name
    }
}

