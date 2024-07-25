//
//  AppStore.swift
//  PokemonMaster
//
//  Created by 孙世伟 on 2024/7/25.
//

import SwiftUI
import Observation

@Observable
class AppStore {
    var pokemonViewModel = PokemonViewModel()
}


struct StoreKey: EnvironmentKey {
    static var defaultValue = AppStore()
}

extension EnvironmentValues {
    var appStore: AppStore {
        get { self[StoreKey.self] }
        set { self[StoreKey.self] = newValue }
    }
}
