//
//  PokemonInfoRow.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/9.
//

import SwiftUI
import Kingfisher

struct PokemonInfoRow: View {
    @EnvironmentObject var store: Store
        
    let model: PokemonViewModel
    let expanded: Bool
    
    var body: some View {
        VStack {
            HStack {
                KFImage(model.iconImageURL)
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
                    let target = !store.appStare.pokemonList.selectionState.panelPresented
                    store.dispatch(.togglePanelPresenting(presenting: target))
                } label: {
                    Image(systemName: "chart.bar")
                        .modifier(ToolButtonModifier())
                }
                Button {
                    store.dispatch(.safarViewPresenting(presenting: true))
                } label: {
                    Image(systemName: "info.circle")
                        .modifier(ToolButtonModifier())
                }
                .navigationDestination(isPresented: $store.appStare.pokemonList.selectionState.isSFViewActive) {
                    SafariView(url: model.detailPageURL) {
                        store.dispatch(.safarViewPresenting(presenting: false))
                    }
                    .navigationTitle(model.name)
                    .navigationBarTitleDisplayMode(.inline)
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
