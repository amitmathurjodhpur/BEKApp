//
//  RequestHandler.swift
//
//  Created by Bhavik on 29/08/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import Foundation
import Alamofire

class RequestHandler: RequestAdapter, RequestRetrier {
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?) -> Void
    
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        return SessionManager(configuration: configuration)
    }()
    
    private let lock = NSLock()
    
    private var baseURLString: String
    private var accessToken: String?
    private var refreshToken: String?
    
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    
    // MARK: - Initialization
    
    public init(baseURLString: String, accessToken: String?, refreshToken: String?) {
        self.baseURLString = baseURLString
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    // MARK: - RequestAdapter
    
    /**
     Preparing Request for Access Token API with RequestAdapter Delegate Method
     - Authors:
     - Created By - Bhavik
     - Modified By -  author name
     - Date:
     - Created At - 29/08/18
     - Modified At - date
     - Version: version
     - Remark: remark
     */
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if let url = urlRequest.url, url.absoluteString.hasPrefix(baseURLString) {
            var urlRequest = urlRequest
            urlRequest.setValue("Bearer " + accessToken!, forHTTPHeaderField: APIKeyConstant.kAuthorization)
            return urlRequest
        }
        
        return urlRequest
    }
    
    // MARK: - RequestRetrier
    
    /**
     Retry Previous request after updating AccessToken and making a recall of api when it has network connection lost.
     - Authors:
     - Created By - Bhavik
     - Modified By - Bhavik Barot
     - Date:
     - Created At - 29/08/18
     - Modified At - 3/12/2018
     - Version:
     - Remark:
     */
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                refreshTokens { [weak self] succeeded, accessToken in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
                    
                    if let accessToken = accessToken {
                        UserDefaultsManager.shardInstance.authToken = accessToken
                        strongSelf.accessToken = accessToken
                    }
                    
                    strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
                    strongSelf.requestsToRetry.removeAll()
                }
            }
        }
        else if let response = request.task?.response as? HTTPURLResponse, response.statusCode == -1005/*NSURLErrorNetworkConnectionLost*/ {
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                debugPrint("::::: Retryer For Network Connection Lost :::::")
                self.lock.lock() ; defer { self.lock.unlock() }
                self.requestsToRetry.forEach { $0(true, 0.0) }
                self.requestsToRetry.removeAll()
            }
        } else {
            completion(false, 0.0)
        }
    }
    
    // MARK: - Private - Refresh Tokens
    
    /**
     Call Refresh Token API
     - Authors:
     - Created By - Bhavik
     - Modified By - <# author name #>
     - Date:
     - Created At - 29/08/18
     - Modified At - <#date#>
     - Version: <#version#>
     - Remark: <#remark#>
     */
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        
        isRefreshing = true
        
        let urlString = HTTPClient().createEndPoint(endPoint: HTTPClient.APIEndPoint.TokenApi)
        
        let parameters: [String: Any] = [
            "refreshToken": refreshToken!,
            ]
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        
        sessionManager.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: header).responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
            
            if response.result.isSuccess {
                
                let responseMapper = TokenRequest(JSON: response.result.value as! [String : Any])
                
                if let token = responseMapper?.data?.token {
                    completion(true, token)
                    
                } else {
                    completion(false, nil)
                }
            }
            strongSelf.isRefreshing = false
        }
    }
}
