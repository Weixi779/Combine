//
//  LoadPokemonsCommand.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/27.
//

import Foundation

struct LoadPokemonsCommand: AppCommand {
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadPokemonRequest.all
            .sink { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.loadPokemonsDone(result: .failure(error)))
                }
                token.unseal()
            } receiveValue: { result in
                store.dispatch(.loadPokemonsDone(result: .success(result)))
            }
            .seal(in: token)
    }
}
