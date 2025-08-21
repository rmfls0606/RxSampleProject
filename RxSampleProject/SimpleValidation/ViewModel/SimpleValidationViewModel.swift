//
//  SimpleValidationViewModel.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SimpleValidationViewModel {
    private(set) var minimalUsernameLength = 5
    private(set) var minimalPasswordLength = 5
    
    struct Input {
        let usernameValid: ControlProperty<String>
        let passwordValid: ControlProperty<String>
        let successButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let usernameValid: Observable<Bool>
        let passwordValid: Observable<Bool>
        let everyhingValid: Observable<Bool>
        let submit: Observable<Void>
    }
    
    func transform(input: Input) -> Output {
        let usernameValid = input.usernameValid
            .withUnretained(self)
            .map({ owner, username in
                username.count >= owner.minimalUsernameLength
            })
            .share(replay: 1)
            
        let passwordValid = input.passwordValid
            .withUnretained(self)
            .map({ owner, password in
                password.count >= owner.minimalPasswordLength
            })
            .share(replay: 1)
        
        let everyhingValid = Observable.combineLatest(usernameValid, passwordValid)
            .map{ $0 && $1}
            .share(replay: 1)
        
        let submit = input.successButtonTapped
            .withLatestFrom(everyhingValid)
            .filter { $0 }
            .map { _ in () }
            
        
        return Output(usernameValid: usernameValid,
                      passwordValid: passwordValid,
                      everyhingValid: everyhingValid,
                      submit: submit
        )
    }
}
