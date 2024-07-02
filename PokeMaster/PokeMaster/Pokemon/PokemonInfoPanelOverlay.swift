//
//  PokemonInfoPanelOverlay.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/7/2.
//

import Foundation
import SwiftUI

struct PokemonInfoPanelOverlay: View {
    let model: PokemonViewModel
    var body: some View {
        VStack {
            Spacer()
            PokemonInfoPanel(model: model)
        }
        .edgesIgnoringSafeArea(.bottom)

    }
}
