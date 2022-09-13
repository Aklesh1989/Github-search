//
//  ParameterEncoding.swift
//  AFNetwork
//
//  Created by Aklesh on 12/09/22.
//

import Alamofire

extension String: ParameterEncoding {
    
    // MARK: - Public Methods
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}
