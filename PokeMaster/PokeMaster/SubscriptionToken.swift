//
//  SubscriptionToken.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/24.
//

import Foundation
import Combine

class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() {
        self.cancellable = nil
    }
}


extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}
