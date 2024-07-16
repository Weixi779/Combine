//
//  PokeMasterApp.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/9.
//

import SwiftUI

@main
struct PokeMasterApp: App {
    @StateObject var store: Store = Store()
    
    var body: some Scene {
        WindowGroup {
            MainTab()
                .environmentObject(store)
        }
    }
}
