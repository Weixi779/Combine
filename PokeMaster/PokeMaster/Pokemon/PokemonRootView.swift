//
//  PokemonRootView.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/16.
//

import SwiftUI

struct PokemonRootView: View {
    @EnvironmentObject var store: Store
    var body: some View {
        NavigationStack {
            if store.appStare.pokemonList.pokemons == nil {
                ProgressView()
                    .onAppear {
                        store.dispatch(.loadPokemons)
                    }
            } else {
                PokemonList()
                    .navigationTitle("宝可梦列表")
            }
        }
        
    }
}

#Preview {
    PokemonRootView()
}
