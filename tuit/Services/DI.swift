//
//  DI.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

let DI = DependencyInjector.shared // quick accessor

/// Dependency injector to share common components across the App.
protocol DependencyInjectorProtocol {
    var apiService: APIServiceProtocol { get }
    var typicodeService: TypicodeServiceProtocol { get }
}

final class DependencyInjector: DependencyInjectorProtocol {

    // singleton
    static let shared: DependencyInjectorProtocol = DependencyInjector()
    private init() { }
    
    // MARK: - DependencyInjectorProtocol
    
    lazy var apiService: APIServiceProtocol = APIService()
    lazy var typicodeService: TypicodeServiceProtocol = {
        return TypicodeService(apiService: apiService)
    }()
}
