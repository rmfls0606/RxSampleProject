//
//  NumberViewModel.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class NumberViewModel{
    
    private let disposeBag = DisposeBag()
    
    struct Input{
        let number1Text: ControlProperty<String>
        let number2Text: ControlProperty<String>
        let number3Text: ControlProperty<String>
    }
    
    struct Output{
        let sumText: BehaviorRelay<String>
    }
    
    func transform(input: Input) -> Output{

        let sumText = BehaviorRelay<String>(value: "")
        
        Observable
            .combineLatest(input.number1Text, input.number2Text, input.number3Text){ textValue1, textValue2, textValue3 in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map{ $0.description }
        .bind(to: sumText)
        .disposed(by: disposeBag)
        
        return Output(sumText: sumText)
    }
}
