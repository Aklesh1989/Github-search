//
//  ApiManagerRetrier.swift
//  AFNetwork
//
//  Created by Aklesh on 12/09/22.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    
    let retryLimit = 3
    let retryDelay: TimeInterval = 10
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let adaptedRequest = urlRequest
        /*guard let token = UserObject.shared.user?.token.accessToken else {
        completion(.success(adaptedRequest))
        return
        }
        adaptedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")*/
        completion(.success(adaptedRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let response = request.task?.response as? HTTPURLResponse
        //Retry for 5xx status codes
        if
          let statusCode = response?.statusCode,
          (500...599).contains(statusCode),
          request.retryCount < retryLimit {
            completion(.retryWithDelay(retryDelay))
        } else {
          return completion(.doNotRetry)
        }
    }
    
}
