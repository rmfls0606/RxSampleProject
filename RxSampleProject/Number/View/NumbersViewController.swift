//
//  NumbersViewController.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class NumbersViewController: BaseViewController {
    
    //MARK: - Property
    private let viewModel = NumberViewModel()
    
    private let disposeBag = DisposeBag()
    
    //MARK: - View
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.alignment = .trailing
        return view
    }()
    
    private let number1: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.textAlignment = .right
        view.keyboardType = .numberPad
        return view
    }()
    
    private let number2: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.textAlignment = .right
        view.keyboardType = .numberPad
        return view
    }()
    
    private let lastNumberBox: UIView = {
        let view = UIView()
        return view
    }()
    
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private let number3: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.textAlignment = .right
        view.keyboardType = .numberPad
        return view
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    override func configureHierarchy() {
        stackView.addArrangedSubview(number1)
        stackView.addArrangedSubview(number2)
        
        lastNumberBox.addSubview(plusLabel)
        lastNumberBox.addSubview(number3)
        
        stackView.addArrangedSubview(lastNumberBox)
        
        stackView.addArrangedSubview(separator)
        
        stackView.addArrangedSubview(resultLabel)
        
        view.addSubview(stackView)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        number1.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        number2.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        plusLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        number3.snp.makeConstraints { make in
            make.leading.equalTo(plusLabel.snp.trailing).offset(8)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.verticalEdges.trailing.equalToSuperview()
        }
        
        separator.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
        
        
    }
    
    override func configureBind() {
        let input = NumberViewModel.Input(
            number1Text: number1.rx.text.orEmpty,
            number2Text: number2.rx.text.orEmpty,
            number3Text: number3.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input: input)
        
        output.sumText
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
