//
//  NetworkManager.swift
//  PokemonMaster
//
//  Created by 孙世伟 on 2024/7/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    public func AssembleComponents(
        _ url: String,
        _ querys: [String: String]? = nil
    ) throws -> URLComponents {
        guard var urlComponents = URLComponents(string: url) else {
            throw NetworkError.invalidURL
        }
        
        if let querys = querys {
            let queryItems = querys.map{ URLQueryItem(name: $0.key, value: $0.value) }
            urlComponents.queryItems = queryItems
        }
        
        return urlComponents
    }
    
    public func AssembleRequest(
        _ method: HTTPMethod,
        _ url: URL?,
        _ bodyParams:  [String: Any]? = nil
    ) throws -> URLRequest {
        guard let url = url else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let bodyParams = bodyParams {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParams, options: [])
        }
        
        if method == .POST {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
    
    public func requestData(
        _ method: HTTPMethod,
        _ urlString: String,
        queryParams: [String: String]? = nil,
        bodyParams: [String: Any]? = nil
    ) async throws -> Data {
        let components = try AssembleComponents(urlString, queryParams)
        let request = try AssembleRequest(method, components.url, bodyParams)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        return data
    }
    
    public func requestModel<T: Decodable>(
        _ method: HTTPMethod,
        _ urlString: String,
        queryParams: [String: String]? = nil,
        bodyParams: [String: Any]? = nil
    ) async throws -> T {
        let data = try await requestData(method, urlString, queryParams: queryParams, bodyParams: bodyParams)
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch let decodingError {
            throw NetworkError.decodingFailed(decodingError)
        }
    }
}
