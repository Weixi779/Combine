//
//  LogoutRequest.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/25.
//

import Foundation
import Combine

struct LogoutRequest {
    var publisher: AnyPublisher<User?, AppError> {
        Future { promise in
            promise(.success(nil))
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
