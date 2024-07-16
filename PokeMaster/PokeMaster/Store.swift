//
//  Store.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/23.
//

import Combine

class Store: ObservableObject {
    @Published var settingViewModel = SettingViewModel()
    @Published var checker = AccountChecker()
    @Published var pokemonList = PokemonModels()
    
    var disposeBag = [AnyCancellable]()
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
        self.checker.isEmailValid
            .sink { isValid in
                self.dispatch(.emialValid(valid: isValid))
            }.store(in: &disposeBag)
        self.checker.isRegisterValid
            .sink { isValid in
                self.dispatch(.registerVaild(valid: isValid))
            }.store(in: &disposeBag)
    }
    
    func dispatch(_ action: AppAction) {
#if DEBUG
        print("[ACTION]:\(action)")
#endif
        let command = reduce(action: action)
        
        if let command = command {
#if DEBUG
            print("[COMMAND]:\(command)")
#endif
            command.execute(in: self)
        }
    }
    
    func reduce(action: AppAction) -> AppCommand? {
        var appCommand: AppCommand?
        switch action {
        case .login(let email, let password):
            guard checker.loginRequesting else {
                break
            }
            self.checker.loginRequesting = true
            appCommand = LoginAppCommand(email: email, password: password)
        case .logout:
            settingViewModel.loginUser = nil
            checker.email = ""
            checker.password = ""
        case .emialValid(let vaild):
            settingViewModel.isEmailValid = vaild
        case .registerVaild(let vaild):
            settingViewModel.isRegisterVaild = vaild
        case .accountBehaviorDone(let result):
            checker.loginRequesting = false
            switch result {
            case .success(let user):
                settingViewModel.loginUser = user
            case .failure(let error):
                checker.loginError = error
            }
        case .loadPokemons:
            if pokemonList.loadingPokemons { break }
            pokemonList.loadingPokemons = true
            appCommand = LoadPokemonsCommand()
        case .loadPokemonsDone(let result):
            pokemonList.loadingPokemons = false
            switch result {
            case .success(let success):
                pokemonList.pokemons = Dictionary(
                    uniqueKeysWithValues: success.map { ($0.id, $0) }
                )
            case .failure(let failure):
                print(failure)
            }
        case .clearPokemonCache:
            pokemonList.pokemons = nil
        case .expandPokemons(let index):
            let lastIndex = pokemonList.selectionState.expandingIndex
            let nextIndex = lastIndex == index ? nil : index
            pokemonList.selectionState.expandingIndex = nextIndex
        case .togglePanelPresenting(let presenting):
            pokemonList.selectionState.panelPresented = presenting
        case .loadAbilities(let pokemon):
            appCommand = LoadAbilitiesCommand(pokemon: pokemon)
        case .loadAbilitiesDone(let result):
            switch result {
            case .success(let loadedAbilities):
                var abilities = pokemonList.abilities ?? [:]
                for ability in loadedAbilities {
                    abilities[ability.id] = ability
                }
                pokemonList.abilities = abilities
            case .failure(let error):
                print(error)
            }
        case .safarViewPresenting(let presenting):
            pokemonList.selectionState.isSFViewActive = presenting
        }
        return appCommand
    }
}
