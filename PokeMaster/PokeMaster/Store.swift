//
//  Store.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/23.
//

import Combine

class Store: ObservableObject {
    @Published var appStore = AppState()
}
