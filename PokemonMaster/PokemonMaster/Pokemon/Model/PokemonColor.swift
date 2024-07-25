//
//  PokemonColor.swift
//  PokemonMaster
//
//  Created by 孙世伟 on 2024/7/25.
//

import Foundation
import CodableWrapper

enum PokemonColor: String {
    case red
    case green
    case colorless
    
    init(color: String) {
        self = .init(rawValue: color) ?? .colorless
    }
    
    static var transformer = TransformOf<PokemonColor, String>(fromJSON: {
        PokemonColor(color: $0 ?? "")
    }, toJSON: {
        $0.rawValue
    })
}
