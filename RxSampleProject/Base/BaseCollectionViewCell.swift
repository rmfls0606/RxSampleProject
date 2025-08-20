//
//  BaseCollectionViewCell.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/20/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHierarchy(){ }
    func configureLayout(){ }
    func configureView(){ }
}
