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
        store.appStore.pokemonList
    }
        
    var body: some View {
        ScrollView {
            LazyVStack{
                ForEach(pokemonModel.allPokemonsByID) { pokemon in
                    PokemonInfoRow(
                        model: pokemon,
                        expanded: pokemonModel.expandingIndex == pokemon.id
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.55, dampingFraction: 0.425))
                        {
                            if let index = pokemonModel.expandingIndex, index == pokemon.id {
                                store.dispatch(.expandPokemons(index: nil))
                            } else {
                                store.dispatch(.expandPokemons(index: pokemon.id))
                            }
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
