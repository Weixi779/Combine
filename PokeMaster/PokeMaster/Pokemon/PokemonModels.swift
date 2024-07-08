//
//  PokemonModels.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/27.
//

import Foundation

struct SelectionState {
    var expandingIndex: Int? = nil
    var panelIndex: Int? = nil
    var panelPresented = false
    var isSFViewActive = false

    func isExpanding(_ id: Int) -> Bool {
        expandingIndex == id
    }
}

struct PokemonModels {
    var selectionState: SelectionState = SelectionState()
    @FileStorage(directory: .cachesDirectory, fileName: "pokemons.json")
    var pokemons: [Int: PokemonViewModel]?
    var allPokemonsByID: [PokemonViewModel] {
        guard let pokemons = pokemons?.values else { return [] }
        return pokemons.sorted { $0.id < $1.id }
    }
    @FileStorage(directory: .cachesDirectory, fileName: "abilities.json")
    var abilities: [Int: AbilityViewModel]?
    func abilityViewModels(for pokemon: Pokemon) -> [AbilityViewModel]? {
        guard let abilities = abilities else { return nil }
        return pokemon.abilities.compactMap { abilities[$0.ability.url.extractedID!] }
    }
    var loadingPokemons = false
    
    var searchText = ""

    func displayPokemons(with settings: Settings) -> [PokemonViewModel] {

        func isFavorite(_ pokemon: PokemonViewModel) -> Bool {
            guard let user = settings.loginUser else { return false }
            return user.isFavoritePokemon(id: pokemon.id)
        }

        func containsSearchText(_ pokemon: PokemonViewModel) -> Bool {
            guard !searchText.isEmpty else {
                return true
            }
            return pokemon.name.contains(searchText) ||
                   pokemon.nameEN.lowercased().contains(searchText.lowercased())
        }

        guard let pokemons = pokemons else {
            return []
        }

        let sortFunc: (PokemonViewModel, PokemonViewModel) -> Bool
        switch settings.sorting {
        case .id:
            sortFunc = { $0.id < $1.id }
        case .name:
            sortFunc = { $0.nameEN < $1.nameEN }
        case .color:
            sortFunc = {
                $0.species.color.name.rawValue < $1.species.color.name.rawValue
            }
        case .favorite:
            sortFunc = { p1, p2 in
                switch (isFavorite(p1), isFavorite(p2)) {
                case (true, true): return p1.id < p2.id
                case (false, false): return p1.id < p2.id
                case (true, false): return true
                case (false, true): return false
                }
            }
        }

        var filterFuncs: [(PokemonViewModel) -> Bool] = []
        filterFuncs.append(containsSearchText)
        if settings.showFavoriteOnly {
            filterFuncs.append(isFavorite)
        }

        let filterFunc = filterFuncs.reduce({ _ in true}) { r, next in
            return { pokemon in
                r(pokemon) && next(pokemon)
            }
        }

        return pokemons.values
            .filter(filterFunc)
            .sorted(by: sortFunc)
    }
}
