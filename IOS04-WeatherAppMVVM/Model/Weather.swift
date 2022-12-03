//
//  Weather.swift
//  IOS04-WeatherAppMVVM
//
//  Created by Mehmet Gökhan Özen on 6.10.2022.
//

import Foundation

struct Root: Decodable {
    let main: Main
    let wind: Wind
    let sys: Sys
}

struct Main: Decodable {
    let temp: Double
}

struct Wind: Decodable {
    let speed: Double
}

struct Sys: Decodable {
    let country: String
}
