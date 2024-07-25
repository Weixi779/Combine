//
//  ContentView.swift
//  PokemonMaster
//
//  Created by 孙世伟 on 2024/7/25.
//

import SwiftUI

struct PokemonListRootView: View {
    @Environment(\.appStore) var store
    var body: some View {
        NavigationStack {
            VStack {
                if let species = store.pokemonViewModel.species {
                    SpeciesView(species: species)
                } else {
                    EmptyView()
                }
            }
            .onAppear { store.pokemonViewModel.requestSpecies() }
        }
        .navigationTitle("列表数据")
    }
}

struct EmptyView: View {
    var body: some View {
        ProgressView()
    }
}

struct SpeciesView: View {
    @State var species: PokemonSpecies
    
    var body: some View {
        VStack {
            Text("color: \(species.color)")
            Text("flavor: \(species.flavorTextEntries)")
        }
    }
}

#Preview {
    PokemonListRootView()
        .environment(AppStore())
}
