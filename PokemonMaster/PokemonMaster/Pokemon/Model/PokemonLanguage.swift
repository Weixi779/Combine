//
//  PokemonLanguage.swift
//  PokemonMaster
//
//  Created by 孙世伟 on 2024/7/25.
//

import Foundation
import CodableWrapper

@Codable
struct PokemonLanguage {
    let name: String
    let url: String
}

extension PokemonLanguage {
    var isSimplified: Bool { self.name == "zh-Hans" }
    var isEnglish: Bool { self.name == "en" }
}
