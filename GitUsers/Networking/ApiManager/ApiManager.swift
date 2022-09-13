//
//  ApiManager.swift
//  AFNetwork
//
//  Created by Aklesh on 12/09/22.
//

import Alamofire

class APIManager {
    
    // MARK: - Vars & Lets
    
    static let shared = APIManager()

    let sessionManager: Session = {
      let configuration = URLSessionConfiguration.af.default
      configuration.requestCachePolicy = .returnCacheDataElseLoad
      let responseCacher = ResponseCacher(behavior: .modify { _, response in
        let userInfo = ["date": Date()]
        return CachedURLResponse(
          response: response.response,
          data: response.data,
          userInfo: userInfo,
          storagePolicy: .allowed)
      })

      let networkLogger = Logger()
      let interceptor = Interceptor()
        

      return Session(
        configuration: configuration,
        interceptor: interceptor,
        cachedResponseHandler: responseCacher,
        eventMonitors: [networkLogger])
    }()
    
    private init () {}
    static let networkEnviroment: NetworkEnvironment = .dev
    
    // MARK: - Public methods
    func call<T:Codable>(type: EndPointType, params: Parameters? = nil, handler: @escaping (Swift.Result<T, AlertMessage>) -> Void){
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { (data) in
                                        do {
                                            guard let jsonData = data.data else {
                                                throw AlertMessage(title: "Error", body: "No data")
                                            }
                                            print("response type is \(T.self)")

                                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                                            print("result type is \(result.self)")

                                            handler(.success(result))
                                        } catch {
                                            if let error = error as? AlertMessage {
                                                return handler(.failure(error))
                                            }
                                            
                                            handler(.failure(self.parseApiError(data: data.data)))
                                        }
        }
    }
    
    // MARK: - Private methods

    private func parseApiError(data: Data?) -> AlertMessage {
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(NetworkError.self, from: jsonData) {
            return AlertMessage(title: Constants.errorAlertTitle, body: error.key ?? error.message)
        }
        return AlertMessage(title: Constants.errorAlertTitle, body: Constants.genericErrorMessage)
    }
    
    public func downloadImage(from imageUrl:String, completionHandler:@escaping ((_ image:UIImage?)->Void)) {
     // let completeImageUrl = baseUrl + imageUrl
        let completeImageUrl =  imageUrl
      guard let url = URL(string: completeImageUrl) else {
        completionHandler(nil)
        return
      }
         getData(from: url) { data, response, error in
             guard let data = data, error == nil else { return }
             print(response?.suggestedFilename ?? url.lastPathComponent)
             print("Download Finished \(data)")
             let image = UIImage(data: data)
             completionHandler(image)
         }
     }

    public func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
