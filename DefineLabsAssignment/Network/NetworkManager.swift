//
//  NetworkManager.swift
//  DefineLabsAssignment
//
//  Created by Rishikesh Yadav on 3/14/21.
//

import Foundation

protocol NetworkManagerDelegate {
    func didUpdateVenueData(with data: ResponseData?)
}

struct NetworkManager {
   // let urlString = "https://api.foursquare.com/v2/venues/search?ll=40.7484,-73.9857&oauth_token=NPKYZ3WZ1VYMNAZ2FLX1WLECAWSMUVOQZOIDBN53F3LVZBPQ&v=20180616"
    let baseUrl = "https://api.foursquare.com/"
    let token = "NPKYZ3WZ1VYMNAZ2FLX1WLECAWSMUVOQZOIDBN53F3LVZBPQ&v=20180616"
    let locationDetails = "40.7484,-73.9857"
    let cocatUrl = "v2/venues/search?ll=40.7484,-73.9857&oauth_token=NPKYZ3WZ1VYMNAZ2FLX1WLECAWSMUVOQZOIDBN53F3LVZBPQ&v=20180616"
    var delegate: NetworkManagerDelegate?
    
    func performRequest()  {
       // let urlValue = baseUrl + "v2/venues/search?ll=\(locationDetails)&oauth_token=\(token)"
     
        let urlString = "https://api.foursquare.com/v2/venues/search?ll=40.7484,-73.9857&oauth_token=NPKYZ3WZ1VYMNAZ2FLX1WLECAWSMUVOQZOIDBN53F3LVZBPQ&v=20180616"
        if let url = URL(string: urlString) {
            let urlSeesion = URLSession(configuration: .default)
            let task = urlSeesion.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                if let safeData = data {
                    let venueData = self.parseJSON(with: safeData)
                    self.delegate?.didUpdateVenueData(with: venueData)
                }
            }
            task.resume()
        }

    }
    
    func parseJSON(with data: Data) -> ResponseData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SearchResponse.self, from: data)
            print(decodedData)
            return decodedData.response
        } catch {
            print(error)
            return nil
        }
    }
}
