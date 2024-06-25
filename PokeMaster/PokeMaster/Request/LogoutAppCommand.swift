//
//  LogoutAppCommand.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/25.
//

import Foundation

struct LogoutAppCommand: AppCommand {
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LogoutRequest()
            .publisher
            .sink { _ in
                token.unseal()
            } receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            }
            .seal(in: token)
    }
}
