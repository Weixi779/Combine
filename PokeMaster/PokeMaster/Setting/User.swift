//
//  User.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/24.
//

import Foundation

struct User: Codable {
    var email: String
    var favoritePokemonIDs: Set<Int>
    
    func isFavoritePokemon(id: Int) -> Bool {
        return favoritePokemonIDs.contains(id)
    }
}
