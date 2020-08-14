//
// CityAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



open class CityAPI {
    /**
     Cities list: Return list of cities with image urls
     
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func listCities(apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: [City]?,_ error: Error?) -> Void)) {
        listCitiesWithRequestBuilder().execute(apiResponseQueue) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Cities list: Return list of cities with image urls
     - GET /cities
     - returns: RequestBuilder<[City]> 
     */
    open class func listCitiesWithRequestBuilder() -> RequestBuilder<[City]> {
        let path = "/cities"
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[City]>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}