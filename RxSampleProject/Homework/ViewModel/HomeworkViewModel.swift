//
//  HomeworkViewModel.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeworkViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let tableViewModelSelected: ControlEvent<Person>
        let searchButtonClicked: ControlEvent<Void>
        let searchInputText: ControlProperty<String>
    }
    
    struct Output {
        let userListReplay: BehaviorRelay<[Person]>
        let selectedUserReplay: BehaviorRelay<[String]>
    }
    
    func transform(input: Input) -> Output {
        let userListReplay: BehaviorRelay<[Person]> = BehaviorRelay(value: [])
        let selectedUserReplay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
        
        userListReplay
            .accept(Person.sampleUsers)
        
        input.tableViewModelSelected
            .distinctUntilChanged({ $0.name == $1.name })
            .bind(with: self) { owner, value in
                var data = selectedUserReplay.value
                data.append(value.name)
                selectedUserReplay.accept(data)
            }
            .disposed(by: disposeBag)
        
        input.searchButtonClicked
            .withLatestFrom(input.searchInputText)
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map({ name -> Person in
                Person(name: name, email: "\(name.lowercased())@example.com", profileImage: "https://img1.daumcdn.net/thumb/C428x428/?scode=mtistory2&fname=https%3A%2F%2Ftistory1.daumcdn.net%2Ftistory%2F7524496%2Fattach%2Ff6fcf888c6404567b3081c3571740d36")
            })
            .bind(with: self, onNext: { owner, value in
                var result = userListReplay.value
                result.append(value)
                userListReplay.accept(result)
            })
            .disposed(by: disposeBag)
        
        return Output(
            userListReplay: userListReplay,
            selectedUserReplay: selectedUserReplay
        )
    }
}
