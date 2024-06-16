//
//  BlurEffect.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/16.
//

import UIKit
import SwiftUI

// 本书更新于SwiftUI 2.0版本 暂未有自带毛玻璃效果, 现在之后已支持故无用

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate(
            [
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
            ]
        )
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

extension View {
    func blurEffect(style: UIBlurEffect.Style) -> some View {
        ZStack {
            BlurView(style: style)
            self
        }
    }
}
