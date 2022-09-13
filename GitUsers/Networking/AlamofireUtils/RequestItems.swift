//
//  RequestItems.swift
//  AFNetwork
//
//  Created by Aklesh on 12/09/22.
//

import Alamofire

// MARK: - Enums

enum NetworkEnvironment {
    case dev
    case production
    case stage
}

enum RequestItemsType {

    // MARK: User
    case searchUser(String)
    case getUser(String)
    case getFollowers(String)
    case getFollowings(String)
    
}

// MARK: - Extensions
// MARK: - EndPointType

extension RequestItemsType: EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String {
        switch APIManager.networkEnviroment {
            case .dev: return "https://api.github.com"
            case .production: return "https://api.github.com"
            case .stage: return "https://api.github.com"
        }
    }
    
    var version: String {
        return ""
    }
    
    var path: String {
        switch self {
        case .searchUser(let query):
            return "/search/users?q=\(query)"
        case .getFollowers(let user):
            return "/users/\(user)/followers"
        case .getFollowings(let user):
            return "/users/\(user)/following"
        case .getUser(let userName):
            return "/users/\(userName)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .searchUser:
            return .get
        case .getFollowers:
            return .get
        case .getFollowings:
            return .get
        case .getUser:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "X-Requested-With": "XMLHttpRequest"]
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}
