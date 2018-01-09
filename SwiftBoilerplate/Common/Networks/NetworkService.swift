//
//  DataProvider.swift
//  SwiftBoilerplate
//
//  Created by Fachri Work on 1/9/18.
//  Copyright © 2018 Fachri Febrian. All rights reserved.
//

import Moya

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

let ISakuDataProvider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

enum NetworkServices {
    case feeds(request: Feeds.Request)
}

extension NetworkService: TargetType {
    
    public var baseURL: URL {
        return URL(string: ApiConstants.baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .feeds:
            return ""
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var task: Task {
        return NetworkTasks.createParams(self)
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
