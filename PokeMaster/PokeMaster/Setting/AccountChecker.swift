//
//  AccountChecker.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/25.
//

import Foundation


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
}
