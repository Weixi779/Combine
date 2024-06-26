//
//  AccountChecker.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/25.
//

import Foundation
import Combine

enum AccountBehavior: CaseIterable {
    case register, login
}

class AccountChecker {
    @Published var accountBehavior = AccountBehavior.login
    @Published var email = ""
    @Published var password = ""
    @Published var verifyPassword = ""
    @Published var loginRequesting = false
    var loginError: AppError?
    
    var isEmailValid: AnyPublisher<Bool, Never> {
        let remoteVerify = $email
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { email -> AnyPublisher<Bool, Never> in
                let validEmail = email.isValidEmailAddress
                let canSkip = self.accountBehavior == .login
                switch (validEmail, canSkip) {
                case (false, _):
                    return Just(true).eraseToAnyPublisher()
                case (true, false):
                    return EmailCheckingRequest(email: email)
                        .pushlisher
                        .eraseToAnyPublisher()
                case (true, true):
                    return Just(true).eraseToAnyPublisher()
                }
            }
        
        let emailLocalVaild = $email.map{ $0.isValidEmailAddress }
        let canSkipRemoteVerify = $accountBehavior.map { $0 == .login }
        
        return Publishers.CombineLatest3(remoteVerify, emailLocalVaild, canSkipRemoteVerify)
            .map{ $0 && ($1 || $2) }
            .eraseToAnyPublisher()
    }
}
