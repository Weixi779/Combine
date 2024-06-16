//
//  PokemonRootView.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/16.
//

import SwiftUI

struct PokemonRootView: View {
    var body: some View {
        NavigationStack {
            PokemonList()
                .navigationTitle("宝可梦列表")
        }
    }
}

#Preview {
    PokemonRootView()
}
