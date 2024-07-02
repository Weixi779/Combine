//
//  PokemenInfoPanel.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/15.
//

import SwiftUI

struct PokemonInfoPanel: View {
    @EnvironmentObject var store: Store
    
    let model: PokemonViewModel
    var abilities: [AbilityViewModel]? {
        store.appStare.pokemonList.abilityViewModels(for: model.pokemon)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            topIndicator
            Group {
                Hedaer(model: model)
                pokemonDescription
                AbilityList(model: model, abilityModels: abilities)
            }
//            .animation(nil, value: UUID())
        }
        .padding(EdgeInsets(top: 12, leading: 30, bottom: 30, trailing: 30))
        .background(.regularMaterial)

        .cornerRadius(20)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    var topIndicator: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 6)
            .opacity(2)
    }
    
    var pokemonDescription: some View {
        Text(model.descriptionText)
            .font(.callout)
            .foregroundColor(Color(hex: 0x666666))
            .fixedSize(horizontal: false, vertical: true)
    }
}

extension PokemonInfoPanel {
    struct Hedaer: View {
        let model: PokemonViewModel
        var body: some View {
            HStack(spacing: 18) {
                pokemonIcon
                nameSpecies
                verticalDivider
                VStack(spacing: 12) {
                    bodyStatus
                    typeInfo
                }
            }
        }
        
        var pokemonIcon: some View {
            Image("Pokemon-\(model.id)")
                .resizable()
                .frame(width: 68, height: 68)
        }
        
        var nameSpecies: some View {
            VStack(spacing: 10) {
                VStack {
                    Text("\(model.name)")
                        .font(.system(size: 22))
                    Text("\(model.nameEN)")
                        .font(.system(size: 13))
                }
                .foregroundColor(model.color)
                Text("\(model.genus)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            .fontWeight(.bold)
        }
        
        var verticalDivider: some View {
            Rectangle()
                .frame(width: 1, height: 44)
                .foregroundColor(Color(hex: 0x000000, alpha: 0.1))
        }
        
        var bodyStatus: some View {
            VStack(spacing: 3) {
                HStack(spacing: 3) {
                    Text("身高")
                        .foregroundColor(.gray)
                    Text("\(model.height)")
                        .foregroundColor(model.color)
                }
                HStack(spacing: 3) {
                    Text("体重")
                        .foregroundColor(.gray)
                    Text("\(model.weight)")
                        .foregroundColor(model.color)
                }
            }
            .font(.system(size: 11))
        }
        
        var typeInfo: some View {
            HStack(spacing: 5) {
                ForEach(model.types) { type in
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 36, height: 14)
                            .foregroundColor(type.color)
                        Text("\(type.name)")
                            .foregroundColor(.white)
                            .font(.system(size: 11))
                    }
                }
            }
        }
    }
}

extension PokemonInfoPanel {
    struct AbilityList: View {
        let model: PokemonViewModel
        let abilityModels: [AbilityViewModel]?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                if let abilityModels = abilityModels {
                    ForEach(abilityModels) { ability in
                        Text(ability.name)
                            .font(.subheadline)
                            .foregroundColor(model.color)
                        Text(ability.descriptionText)
                            .font(.footnote)
                            .foregroundColor(Color(hex: 0xAAAAAA))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    PokemonInfoPanel(model: .sample(id: 1))
}
