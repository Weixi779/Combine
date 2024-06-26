//
//  Settings.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/16.
//

import Foundation

struct Settings {
    @FileStorage(directory: .documentDirectory, fileName: "user.json")
    var loginUser: User?
    
    enum Sorting: CaseIterable, Codable {
        case id, name, color, favorite
    }
    
    @UserDefaultsStorage(defaultValue: Sorting.id, key: "sorting")
    var sorting: Sorting
    @UserDefaultsStorage(defaultValue: true, key: "showEnglishName")
    var showEnglishName: Bool
    @UserDefaultsStorage(defaultValue: false, key: "showFavoriteOnly")
    var showFavoriteOnly: Bool
    
    var isEmailValid: Bool = false
}


extension Settings.Sorting {
    var text: String {
        switch self {
        case .id: return "ID"
        case .name: return "名字"
        case .color: return "颜色"
        case .favorite: return "最爱"
        }
    }
}


extension AccountBehavior {
    var text: String {
        switch self {
        case .register: return "注册"
        case .login: return "登录"
        }
    }
}
