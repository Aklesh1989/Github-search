//
//  Logger.swift
//  AFNetwork
//
//  Created by Aklesh on 12/09/22.
//

import Foundation
import Alamofire

class Logger: EventMonitor {
  let queue = DispatchQueue(label: "com.AFNetwork.Test.networklogger")

  func requestDidFinish(_ request: Request) {
    print(request.description)
  }

  func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    guard let data = response.data else {
      return
    }
    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
      print(json)
    }
  }
}
