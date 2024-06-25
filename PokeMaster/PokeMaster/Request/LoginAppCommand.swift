//
//  LoginAppCommand.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/24.
//

import Foundation

struct LoginAppCommand: AppCommand {
    let email: String
    let password: String
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoginRequest(email: email, password: password)
            .publisher
            .sink { complete in
                if case let .failure(error) = complete {
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
                token.unseal()
            } receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            }
            .seal(in: token)
    }
}
