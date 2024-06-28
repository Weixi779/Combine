//
//  SettingView.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/16.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var store: Store
    
    @State private var isGreenColor: Bool = true
    
    var settingBinding: Binding<Settings> {
        $store.appStore.settings
    }
    
    var checkerBinding: Binding<AccountChecker> {
        $store.appStore.checker
    }
    
    var checker: AccountChecker {
        store.appStore.checker
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
        .alert(item: checkerBinding.loginError) { error in
            Alert(title: Text(error.localizedDescription))
        }
    }
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            if let user = settings.loginUser {
                Text(user.email)
                Button("注销") {
                    self.store.dispatch(AppAction.logout)
                }
            } else {
                Picker(selection: checkerBinding.accountBehavior, label: Text("")) {
                    ForEach(AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("电子邮箱", text: checkerBinding.email, onEditingChanged: { isEditing in
                    isGreenColor = settings.isEmailValid
                })
                .onChange(of: settings.isEmailValid) { oldValue, newValue in
                    isGreenColor = newValue
                }
                .foregroundColor(isGreenColor ? .green : .red)
                
                SecureField("密码", text: checkerBinding.password)
                
                if checker.accountBehavior == .register {
                    SecureField("密码", text: checkerBinding.verifyPassword)
                }
                
                if checker.loginRequesting {
                    ProgressView()
                } else {
                    Button(checker.accountBehavior.text) {
                        let action = AppAction.login(
                            email: checker.email,
                            password: checker.password
                        )
                        self.store.dispatch(action)
                    }
                }
            }
        }
    }
    
    var optionSection: some View {
        Section(header: Text("选项")) {
            Picker(selection: settingBinding.sorting, label: Text("排序方式")) {
                ForEach(Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            Toggle(isOn: settingBinding.showEnglishName) {
                Text("显示英文名")
            }
            Toggle(isOn: settingBinding.showFavoriteOnly) {
                Text("只显示收藏")
            }
        }
    }
    
    var actionSection: some View {
        Section {
            Button(action: {
                store.dispatch(.clearPokemonCache)
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
