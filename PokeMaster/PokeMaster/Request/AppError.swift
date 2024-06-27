//
//  AppError.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/24.
//

import Foundation

enum AppError: Error, Identifiable {
    var id: String { localizedDescription }
    case passwordWrong
    case networkingFailed(Error)
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .passwordWrong: return "密码错误"
        case .networkingFailed(let error): return error.localizedDescription
        }
    }
}
