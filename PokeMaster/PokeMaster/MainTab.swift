//
//  MainTab.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/23.
//

import SwiftUI

struct MainTab: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        TabView {
            PokemonRootView().tabItem {
                Image(systemName: "list.bullet.below.rectangle")
                Text("列表")
            }
            
            SettingRootView().tabItem {
                Image(systemName: "gear")
                Text("设置")
            }
        }
        .ignoresSafeArea(edges: .top)
        .overlay(panel)
    }
    
    var panel: some View {
        Group {
            if store.appStare.pokemonList.selectionState.panelPresented {
                if let index = store.appStare.pokemonList.selectionState.expandingIndex,
                   let pokemons = store.appStare.pokemonList.pokemons {
                    let targetPokemon = pokemons[index]
                    PokemonInfoPanelOverlay(model: targetPokemon!)
                }
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    MainTab()
}
