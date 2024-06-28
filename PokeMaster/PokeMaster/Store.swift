//
//  Store.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/23.
//

import Combine

class Store: ObservableObject {
    @Published var appStore = AppState()
    
    var disposeBag = [AnyCancellable]()
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
        self.appStore.checker.isEmailValid
            .sink { isValid in
                self.dispatch(.emialValid(valid: isValid))
            }.store(in: &disposeBag)
        self.appStore.checker.isRegisterValid
            .sink { isValid in
                self.dispatch(.registerVaild(valid: isValid))
            }.store(in: &disposeBag)
    }
    
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
            appState.settings.loginUser = nil
            appState.checker.email = ""
            appState.checker.password = ""
        case .emialValid(let vaild):
            appState.settings.isEmailValid = vaild
        case .registerVaild(let vaild):
            appState.settings.isRegisterVaild = vaild
        case .accountBehaviorDone(let result):
            appState.checker.loginRequesting = false
            switch result {
            case .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                appState.checker.loginError = error
            }
        case .loadPokemons:
            if appState.pokemonList.loadingPokemons { break }
            appState.pokemonList.loadingPokemons = true
            appCommand = LoadPokemonsCommand()
        case .loadPokemonsDone(let result):
            appState.pokemonList.loadingPokemons = false
            switch result {
            case .success(let success):
                appState.pokemonList.pokemons = Dictionary(
                    uniqueKeysWithValues: success.map { ($0.id, $0) }
                )
            case .failure(let failure):
                print(failure)
            }
        case .clearPokemonCache:
            appState.pokemonList.pokemons = nil
        }
        return (appState, appCommand)
    }
}
