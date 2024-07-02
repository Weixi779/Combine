//
//  OverlaySheet.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/7/2.
//

import Foundation
import SwiftUI

struct OverlaySheet<Content: View>: View {
    
    private let isPresented: Binding<Bool>
    private let makeContent: () -> Content
    
    @GestureState private var translation = CGPoint.zero
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.makeContent = content
    }
    
    var body: some View {
        VStack {
            Spacer()
            makeContent()
        }
        .offset(y: isPresented.wrappedValue ? 0 : UIScreen.main.bounds.height)
        .animation(.interpolatingSpring(stiffness: 70, damping: 12), value: isPresented.wrappedValue)
        .gesture(panelDraggingGesture)
        .ignoresSafeArea(edges: .bottom)
    }
    
    var panelDraggingGesture: some Gesture {
        DragGesture()
            .updating($translation) { current, state, _ in
                state.y = current.translation.height
            }
            .onEnded { state in
                if state.translation.height > 50 {
                    self.isPresented.wrappedValue = false
                }
            }
    }
}

extension View {
    func overlaySheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        overlay(
            OverlaySheet(isPresented: isPresented, content: content)
        )
    }
}
