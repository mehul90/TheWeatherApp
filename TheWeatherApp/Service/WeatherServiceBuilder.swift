//
//  WeatherServiceBuilder.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

struct WeatherServiceBuilder {
    
    let configuration: ConfigType // the base URl, env., etc.
    init(config: ConfigType = Config(bundle: Bundle.main, locale: Locale.current)) {
        configuration = config
    }

    func build() -> WeatherService {
        let baseURLString = configuration.baseURLString
        let APIKey = configuration.APIKey

        return WeatherServiceImplementation(baseURLString: baseURLString, APIKey: APIKey, session: URLSession.shared)
    }
}
