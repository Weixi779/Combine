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
            VStack(alignment: .leading) {
                if let species = store.pokemonViewModel.species {
                    SpeciesView(species: species)
                } else {
                    EmptyView()
                }
                Spacer()
            }
            .navigationTitle("列表数据")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { store.pokemonViewModel.requestSpecies() }
        }
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
        VStack(alignment: .leading, spacing: 8) {
            Text("简介:")
                .font(.headline)
            Divider()
            ForEach(species.flavorTexts, id: \.self) { text in
                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    PokemonListRootView()
        .environment(AppStore())
}
