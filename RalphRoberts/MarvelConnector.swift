//
//  MarvelConnector.swift
//  RalphRoberts
//
//  Created by John Scott on 09/05/2018.
//  Copyright © 2018 John Scott. All rights reserved.
//

import Foundation

enum MarvelError: Error
{
    case Smeg
}

class MarvelConnector
{
    // The following structs are imported (almost) directly from https://developer.marvel.com/docs#!/public/getCreatorCollection_get_0
    // BBEdit was used to perform certain simple regular expression based search / replaces.
    
    public struct CharacterDataWrapper: Decodable {
        var code: Int? = nil // The HTTP status code of the returned result.,
        var status: String? = nil // A string description of the call status.,
        var copyright: String? = nil // The copyright notice for the returned result.,
        var attributionText: String? = nil // The attribution notice for this result. Please display either this notice or the contents of the attributionHTML field on all screens which contain data from the Marvel Comics API.,
        var attributionHTML: String? = nil // An HTML representation of the attribution notice for this result. Please display either this notice or the contents of the attributionText field on all screens which contain data from the Marvel Comics API.,
        var data: CharacterDataContainer? = nil // The results returned by the call.,
        var etag: String? = nil // A digest value of the content returned by the call.
    }
    
    public struct CharacterDataContainer: Decodable {
        var offset: Int? = nil // The requested offset (number of skipped results) of the call.,
        var limit: Int? = nil // The requested result limit.,
        var total: Int? = nil // The total number of resources available given the current filter set.,
        var count: Int? = nil // The total number of results returned by this call.,
        var results: [Character]? = nil // The list of characters returned by the call.
    }
    
    public struct Character: Decodable {
        var id: Int? = nil // The unique ID of the character resource.,
        var name: String? = nil // The name of the character.,
        var description: String? = nil // A short bio or description of the character.,
        var modified: Date? = nil // The date the resource was most recently modified.,
        var resourceURI: String? = nil // The canonical URL identifier for this resource.,
        var urls: [Url]? = nil // A set of public web site URLs for the resource.,
        var thumbnail: Image? = nil // The representative image for this character.,
        var comics: ComicList? = nil // A resource list containing comics which feature this character.,
        var stories: StoryList? = nil // A resource list of stories in which this character appears.,
        var events: EventList? = nil // A resource list of events in which this character appears.,
        var series: SeriesList? = nil // A resource list of series in which this character appears.
    }
    
    public struct Url: Decodable {
        var type: String? = nil // A text identifier for the URL.,
        var url: String? = nil // A full URL (including scheme, domain, and path).
    }
    
    public struct Image: Decodable {
        var path: String? = nil // The directory path of to the image.,
        var `extension` : String? = nil // The file extension for the image.
    }
    
    public struct ComicList: Decodable {
        var available: Int? = nil // The number of total available issues in this list. Will always be greater than or equal to the "returned" value.,
        var returned: Int? = nil // The number of issues returned in this collection (up to 20).,
        var collectionURI: String? = nil // The path to the full list of issues in this collection.,
        var items: [ComicSummary]? = nil // The list of returned issues in this collection.
    }
    
    public struct ComicSummary: Decodable {
        var resourceURI: String? = nil // The path to the individual comic resource.,
        var name: String? = nil // The canonical name of the comic.
    }
    
    public struct StoryList: Decodable {
        var available: Int? = nil // The number of total available stories in this list. Will always be greater than or equal to the "returned" value.,
        var returned: Int? = nil // The number of stories returned in this collection (up to 20).,
        var collectionURI: String? = nil // The path to the full list of stories in this collection.,
        var items: [StorySummary]? = nil // The list of returned stories in this collection.
    }
    
    public struct StorySummary: Decodable {
        var resourceURI: String? = nil // The path to the individual story resource.,
        var name: String? = nil // The canonical name of the story.,
        var type: String? = nil // The type of the story (interior or cover).
    }
    
    public struct EventList: Decodable {
        var available: Int? = nil // The number of total available events in this list. Will always be greater than or equal to the "returned" value.,
        var returned: Int? = nil // The number of events returned in this collection (up to 20).,
        var collectionURI: String? = nil // The path to the full list of events in this collection.,
        var items: [EventSummary]? = nil // The list of returned events in this collection.
    }
    
    public struct EventSummary: Decodable {
        var resourceURI: String? = nil // The path to the individual event resource.,
        var name: String? = nil // The name of the event.
    }
    
    public struct SeriesList: Decodable {
        var available: Int? = nil // The number of total available series in this list. Will always be greater than or equal to the "returned" value.,
        var returned: Int? = nil // The number of series returned in this collection (up to 20).,
        var collectionURI: String? = nil // The path to the full list of series in this collection.,
        var items: [SeriesSummary]? = nil // The list of returned series in this collection.
    }
    
    public struct SeriesSummary: Decodable {
        var resourceURI: String? = nil // The path to the individual series resource.,
        var name: String? = nil // The canonical name of the series.
    }
    
    
    func getCharacters(completion: @escaping ([Character]?, Error?) -> Void) throws
    {
        guard var urlComponents = URLComponents(string: "https://gateway.marvel.com/v1/public/characters") else {
            throw MarvelError.Smeg
        }
        
        let timestamp = UUID().uuidString
        
        let publicKey : String = <#Marvel Comics API Public Key#>
        let privateKey : String = <#Marvel Comics API Private Key#>
        
        let hash = "\(timestamp)\(privateKey)\(publicKey)".data(using: .utf8)?.md5().hexEncodedString()
        
        var queryItems : [URLQueryItem] = []
        
        queryItems.append(URLQueryItem(name: "ts", value: timestamp))
        queryItems.append(URLQueryItem(name: "apikey", value: publicKey))
        queryItems.append(URLQueryItem(name: "hash", value: hash))
        queryItems.append(URLQueryItem(name: "limit", value: "50"))

        urlComponents.queryItems = queryItems
        
        guard let requestUrl = urlComponents.url else {
            throw MarvelError.Smeg
        }
        
        let request = URLRequest(url: requestUrl)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data=data else
            {
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let characterDataWrapper = try? decoder.decode(CharacterDataWrapper.self, from: data)
            
            DispatchQueue.main.async {
                completion(characterDataWrapper?.data?.results, error)
            }
        }.resume()
    }
    
}
