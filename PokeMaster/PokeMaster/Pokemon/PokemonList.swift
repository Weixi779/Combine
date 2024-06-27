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
    
    @State var expandingIndex: Int?
    
    var body: some View {
        ScrollView {
            LazyVStack{
                ForEach(pokemonModel.allPokemonsByID) { pokemon in
                    PokemonInfoRow(
                        model: pokemon,
                        expanded: self.expandingIndex == pokemon.id
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.55, dampingFraction: 0.425))
                        {
                            if self.expandingIndex == pokemon.id {
                                self.expandingIndex = nil
                            } else {
                                self.expandingIndex = pokemon.id
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
