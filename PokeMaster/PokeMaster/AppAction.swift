//
//  AppAction.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/24.
//

import Foundation

enum AppAction {
    case login(email: String, password: String)
    case logout
    case accountBehaviorDone(result: Result<User?, AppError>)
}
