//
//  PokemonMasterApp.swift
//  PokemonMaster
//
//  Created by 孙世伟 on 2024/7/25.
//

import SwiftUI

@main
struct PokemonMasterApp: App {
    @State var store: AppStore = AppStore()
    
    var body: some Scene {
        WindowGroup {
            PokemonListRootView()
                .environment(store)
        }
    }
}
