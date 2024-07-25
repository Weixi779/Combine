//
//  PokemonViewModel.swift
//  PokemonMaster
//
//  Created by 孙世伟 on 2024/7/25.
//

import Foundation

@Observable
class PokemonViewModel {
    var species: PokemonSpecies?
    
    func requestSpecies() async throws {
        Task {
            do {
                species = try await PokemonRequest.getSpeciesInfo("1")
            }
        }
    }
}
