//
//  EmailCheckingRequest.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/25.
//

import Foundation
import Combine

struct EmailCheckingRequest {
    let email: String
    var pushlisher: AnyPublisher<Bool, Never> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                if self.email.lowercased() == "test@gmail.com" {
                    promise(.success(false))
                } else {
                    promise(.success(true))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
