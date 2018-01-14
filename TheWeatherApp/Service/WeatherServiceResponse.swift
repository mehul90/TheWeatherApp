//
//  WeatherServiceResponse.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

struct TodayResponseModel: Decodable {
    
    struct Weather: Decodable {
        var main: String
        var description: String
    }
    
    struct Wind: Decodable {
        var speed: Double
        var deg: Double
    }
    
    var weather: [Weather]
    var wind: Wind
}

struct TodayResponse {
    enum Status {
        case success(listViewModel: TodayResponseModel)
        case failure(error: Error)
    }
    
    let status: Status
}

//MARK:-
struct FiveDayResponseModel: Decodable {
    
    struct Weather: Decodable {
        var main: String
        var description: String
    }
    
    struct Wind: Decodable {
        var speed: Double
        var deg: Double
    }
    
    struct ThreeHourUpdate: Decodable {
        var dt: Double
        var weather: [Weather]
        var wind: Wind
    }
    
    var list: [ThreeHourUpdate]
}

struct FiveDayResponse {
    enum Status {
        case success(listViewModel: FiveDayResponseModel)
        case failure(error: Error)
    }
    
    let status: Status
}
