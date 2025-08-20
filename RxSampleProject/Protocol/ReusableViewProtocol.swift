//
//  ReusableViewProtocol.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/20/25.
//

import UIKit

protocol ReusableViewProtocol{
    static var identifier: String {get}
}

extension UITableViewCell: ReusableViewProtocol{
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol{
    static var identifier: String {
        return String(describing: self)
    }
}
