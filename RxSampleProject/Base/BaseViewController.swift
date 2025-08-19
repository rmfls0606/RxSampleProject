//
//  BaseViewController.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/20/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad(){
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        configureBind()
    }
    
    func configureHierarchy(){ }
    func configureLayout(){ }
    func configureView(){ }
    func configureBind(){ }
}
