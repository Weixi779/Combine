//
//  PokemonInfoRow.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/9.
//

import SwiftUI

struct PokemonInfoRow: View {
    let model: PokemonViewModel
    let expanded: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image("Pokemon-\(model.id)")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(model.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(.white)
                    Text(model.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 12)
            Spacer()
            HStack(spacing: expanded ? 20 : -30) {
                Spacer()
                Button {
                    // - TODO: Fav
                } label: {
                    Image(systemName: "star")
                        .modifier(ToolButtonModifier())
                }
                
                Button {
                    // - TODO: Panel
                } label: {
                    Image(systemName: "chart.bar")
                        .modifier(ToolButtonModifier())
                }
                
                Button {
                    // - TODO: Web
                } label: {
                    Image(systemName: "info.circle")
                        .modifier(ToolButtonModifier())
                }
            }
            .padding(.bottom, 12)
            .opacity(expanded ? 1.0 : 0.0)
            .frame(maxHeight: expanded ? .infinity : 0)
        }
        .frame(height: expanded ? 120 : 80)
        .padding(.leading, 23)
        .padding(.trailing, 15)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(model.color, style: StrokeStyle(lineWidth: 4))
                RoundedRectangle(cornerRadius: 20)
                    .fill(horizontalGradient([.white, model.color]))
            }
        }
        .padding(.horizontal)
    }
    
    func horizontalGradient(_ colors: [Color]) -> LinearGradient {
        return LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
    }
}

struct ToolButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
    }
}

#if DEBUG
#Preview {
    return VStack {
        PokemonInfoRow(model: PokemonViewModel.sample(id: 1), expanded: false)
        PokemonInfoRow(model: PokemonViewModel.sample(id: 21), expanded: true)
        PokemonInfoRow(model: PokemonViewModel.sample(id: 25), expanded: false)
    }
}
#endif
