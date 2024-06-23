//
//  SettingView.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/16.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var store: Store
    var settingBinding: Binding<Settings> {
        $store.appStore.setting
    }
    
    var settings: Settings {
        store.appStore.setting
    }
    
    var body: some View {
        Form {
            accountSection
            optionSection
            actionSection
        }
    }
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            Picker(selection: settingBinding.accountBehavior, label: Text("")) {
                ForEach(Settings.AccountBehavior.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            TextField("电子邮箱", text: settingBinding.email)
            SecureField("密码", text: settingBinding.password)
            
            if settings.accountBehavior == .register {
                SecureField("密码", text: settingBinding.verifyPassword)
            }
           Button(settings.accountBehavior.text) {
                print("登录/注册")
            }
        }
    }
    
    var optionSection: some View {
        Section(header: Text("选项")) {
            Toggle(isOn: settingBinding.showEnglishName) {
                Text("显示英文名")
            }
            Picker(selection: settingBinding.sorting, label: Text("排序方式")) {
                ForEach(Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            
            Toggle(isOn: settingBinding.showFavoriteOnly) {
                Text("只显示收藏")
            }
        }
    }
    
    var actionSection: some View {
        Section {
            Button(action: {
                print("清空缓存")
            }, label: {
                Text("清空缓存")
                    .foregroundStyle(.red)
            })
        }
    }
}

#Preview {
    SettingView()
        .environmentObject(Store())
}
