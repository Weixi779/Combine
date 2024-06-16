//
//  SettingRootView.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/16.
//

import SwiftUI

struct SettingRootView: View {
    var body: some View {
        NavigationStack {
            SettingView()
                .navigationTitle("设置")
        }
    }
}

#Preview {
    SettingRootView()
}
