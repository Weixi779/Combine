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
        $store.appStore.settings
    }
    
    var settings: Settings {
        store.appStore.settings
    }
    
    var body: some View {
        Form {
            accountSection
            optionSection
            actionSection
        }
        .alert(item: settingBinding.loginError) { error in
            Alert(title: Text(error.localizedDescription))
        }
    }
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            if settings.loginUser == nil {
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
                
                if settings.loginRequesting {
                    ProgressView()
                } else {
                    Button(settings.accountBehavior.text) {
                        let action = AppAction.login(
                            email: self.settings.email,
                            password: self.settings.password
                        )
                        self.store.dispatch(action)
                    }
                }
            } else {
                Text(settings.loginUser!.email)
                Button("注销") {
                    self.store.dispatch(AppAction.logout)
                }
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
