//
//  PokemonModels.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/27.
//

import Foundation

struct PokemonModels {
    @FileStorage(directory: .cachesDirectory, fileName: "pokemons.json")
    var pokemons: [Int: PokemonViewModel]?
    var loadingPokemons = false
    
    var allPokemonsByID: [PokemonViewModel] {
        guard let pokemons = pokemons?.values else { return [] }
        return pokemons.sorted { $0.id < $1.id }
    }
}
