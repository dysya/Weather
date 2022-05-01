//
//  URLConstant.swift
//  WeatherAppV2
//
//  Created by dan4 on 01.05.2022.
//

import Foundation

struct UrlAndKey {
    struct ProductionServer {
        static let baseURL = "https://api.openweathermap.org/data/2.5"
        static let apiKey = "&appid=f7068f7aea2edf395ed544035d7ddf36"
    }
    
    struct APIParameterKey {
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
