//
//  APICongigguration.swift
//  WeatherAppV2
//
//  Created by dan4 on 01.05.2022.
//

import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
