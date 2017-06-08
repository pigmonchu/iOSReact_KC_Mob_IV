//
//  Issue.swift
//  ComicList
//
//  Created by pigmonchu on 8/6/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import Networking

struct Issue {
    
    /// Issue title
    let title: String
    
    /// Cover image URL
    let coverURL: URL?
}

extension Issue: JSONDecodable {
    init(jsonDictionary: JSONDictionary) throws {
        let maybeTitle:String? = try? unpack(from: jsonDictionary, key: "name")
        if maybeTitle == nil {
            title = ""
        } else {
            title = maybeTitle!
        }
        
        coverURL = try? unpack(from: jsonDictionary, keyPath: "image.small_url")
    }

}


extension Issue {
    
    //http://www.comicvine.com/api/issues/?api_key=75d580a0593b7320727309feb6309f62def786cd&field_list=id,image,name,volume&filter=volume:33509&format=json"
    public static func allIssues(ofVolume volumeId: Int64) -> Resource<Response<Issue>> {
        return Resource(
            comicVinePath: "issues",
            parameters: [
                "api_key": apiKey,
                "format": "json",
                "field_list": "id,image,name,volume",
                "filter": "volume:\(volumeId)",
            ]
        )
    }
}


