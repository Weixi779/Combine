//
//  Store.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/23.
//

import Combine

class Store: ObservableObject {
    @Published var appStore = AppState()
    
    func dispatch(_ action: AppAction) {
#if DEBUG
        print("[ACTION]:\(action)")
#endif
        let result = Store.reduce(state: appStore, action: action)
        appStore = result.0
        if let command = result.1 {
#if DEBUG
            print("[COMMAND]:\(command)")
#endif
            command.execute(in: self)
        }
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand?
        switch action {
        case .login(let email, let password):
            guard !appState.checker.loginRequesting else {
                break
            }
            appState.checker.loginRequesting = true
            appCommand = LoginAppCommand(email: email, password: password)
        case .logout:
            appCommand = LogoutAppCommand()
        case .accountBehaviorDone(let result):
            appState.checker.loginRequesting = false
            switch result {
            case .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                appState.checker.loginError = error
            }
        }
        return (appState, appCommand)
    }
}
