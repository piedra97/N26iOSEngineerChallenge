//
//  ServiceLayer.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 1/4/21.
//

import Foundation

class ServiceLayer {
    
    
    class func request<T: Codable>(router: Router, completion: @escaping (Result<T?, Error>) -> ()) {
        //build url components
        let urlComponents = buildURLComponents(router: router)
        
        //Start request to the server if url request is valid
        if let urlRequest = createURLRequest(router: router, urlComponents: urlComponents) {
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                
                //Make sure there are no errors or else pass the error into the completion
                if let err = error {
                    completion(.failure(err))
            
                    return
                }
                guard response != nil, let data = data else {
                    return
                }
                
                //Start decoding response object because we ensure the data
                let responseObject = try? JSONDecoder().decode(T.self, from: data)
                
                //Change to main thread
                DispatchQueue.main.async {
                    //Return coded object
                    completion(.success(responseObject))
                }
            }
            
            dataTask.resume()
        }
    }
    
    private class func buildURLComponents(router: Router) -> URLComponents {
        //Build url components
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        return components
    }
    
    
    private class func createURLRequest(router: Router, urlComponents: URLComponents) -> URLRequest? {
        // Make sure url is valid
        guard let url = urlComponents.url else {
            return nil
        }
        // Create url Request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        return urlRequest
    }
    
}

