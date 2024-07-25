//
//  PokemonRequest.swift
//  PokemonMaster
//
//  Created by 孙世伟 on 2024/7/25.
//

import Foundation

struct PokemonRequest {
    public static func getSpeciesInfo(_ pokemonId: String) async throws -> PokemonSpecies {
        let path = "https://pokeapi.co/api/v2/pokemon-species/" + "\(pokemonId)"
        return try await NetworkManager.shared.requestModel(.GET, path)
    }
}
