//
//  AppAction.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/24.
//

import Foundation

enum AppAction {
    // MARK: Pokemons
    case loadPokemons
    case loadPokemonsDone(result: Result<[PokemonViewModel], AppError>)
    case loadAbilities(pokemon: Pokemon)
    case loadAbilitiesDone(result: Result<[AbilityViewModel], AppError>)
    case expandPokemons(index: Int?)
    case togglePanelPresenting(presenting: Bool)
    case safarViewPresenting(presenting: Bool)
    // MARK: Setting
    case login(email: String, password: String)
    case logout
    case emialValid(valid: Bool)
    case registerVaild(valid: Bool)
    case accountBehaviorDone(result: Result<User?, AppError>)
    case clearPokemonCache
    
}
