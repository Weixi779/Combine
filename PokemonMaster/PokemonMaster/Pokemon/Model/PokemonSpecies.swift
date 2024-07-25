//
//  PokemonSpecies.swift
//  PokemonMaster
//
//  Created by 孙世伟 on 2024/7/25.
//

import Foundation
import CodableWrapper

@Codable
class PokemonSpecies {
    var baseHappiness: Int
    var captureRate: Int
    @CodingNestedKey("color.name")
    @CodingTransformer(PokemonColor.transformer)
    var color: PokemonColor
//    var evolution_chain: LSEvolution_chainModel?
//    var flavor_text_entries: Array<LSFlavor_text_entriesModel>?
//    var form_descriptions: Array<Any>?
//    var forms_switchable: Bool?
//    var gender_rate: Int?
//    var genera: Array<LSGeneraModel>?
//    var generation: LSColorModel?
//    var growth_rate: LSColorModel?
//    var habitat: LSColorModel?
//    var has_gender_differences: Bool?
//    var hatch_counter: Int?
//    var id: Int?
//    var is_baby: Bool?
//    var is_legendary: Bool?
//    var is_mythical: Bool?
//    var name: String?
//    var names: Array<LSNamesModel>?
//    var order: Int?
//    var pal_park_encounters: Array<LSPal_park_encountersModel>?
//    var pokedex_numbers: Array<LSPokedex_numbersModel>?
//    var shape: LSColorModel?
//    var varieties: Array<LSVarietiesModel>?
}
