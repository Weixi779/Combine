//
//  PokemonList.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/15.
//

import SwiftUI

struct PokemonList: View {
    @EnvironmentObject var store: Store
    
    var pokemonModel: PokemonModels {
        store.appStare.pokemonList
    }
        
    var body: some View {
        ScrollView {
            LazyVStack{
                TextField("搜索", text: $store.appStare.pokemonList.searchText.animation(nil))
                    .frame(height: 40)
                    .padding(.horizontal, 25)
                ForEach(pokemonModel.displayPokemons(with: store.appStare.settings)) { pokemon in
                    PokemonInfoRow(
                        model: pokemon,
                        expanded: pokemonModel.selectionState.isExpanding(pokemon.id)
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.55, dampingFraction: 0.425))
                        {
                            store.dispatch(.expandPokemons(index: pokemon.id))
                            store.dispatch(.loadAbilities(pokemon: pokemon.pokemon))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PokemonList()
}
