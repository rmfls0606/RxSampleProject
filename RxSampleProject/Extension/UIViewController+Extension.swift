//
//  UIViewController+Extension.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/20/25.
//

import UIKit

extension UIViewController {
    func showAlert(
        title: String,
        message: String,
        okHandler: @escaping () -> Void
    ){
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let ok = UIAlertAction(title: "확인", style: .default){ _ in
            okHandler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
