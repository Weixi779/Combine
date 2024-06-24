//
//  AppCommand.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/24.
//

import Foundation

protocol AppCommand {
    func execute(in store: Store)
}
