//
//  APIClient.swift
//  WeatherAppV2
//
//  Created by dan4 on 01.05.2022.
//

import Alamofire

class APIClient {
    static func weatherByCity(name: String, completion:@escaping (Result<WeatherData, AFError>)->Void) {
        AF.request(APIRouter.weatherByCity(name: name))
                 .responseDecodable { (response: DataResponse<WeatherData, AFError>) in
            completion(response.result)
        }
    }
}
