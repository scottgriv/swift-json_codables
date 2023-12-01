// Author: Scott Grivner
// Website: scottgrivner.dev
// Abstract:
// Introduced in Swift 4, the Codable API enables us to leverage the compiler in order to generate much of the code needed to encode and decode data to/from a serialized format, like JSON.

import Foundation

// Header Structure
struct Header: Decodable {
    let current_language_code: String?
    let current_language_name: String?
    
    private enum CodingKeys: String, CodingKey {
        case current_language_code = "current_language_code"
        case current_language_name = "current_language_name"
    }
}

// Details Structure
struct Details: Decodable {
    let language_code: String?
    let language_name: String?
    
    enum CodingKeys: String, CodingKey {
        case language_code = "language_code"
        case language_name = "language_name"
    }
}

// Root Structure
struct Root: Decodable {
    let header: [Header]?
    let details: [Details]?
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        header = try container.decode([Header].self, forKey: .header)
        details = try container.decode([Details].self, forKey: .details)
    }
    
    enum CodingKeys: String, CodingKey {
        case header
        case details
    }
}

// Declare JSON
let json = """
{
    "header": [{
        "current_language_code": "ru",
        "current_language_name": "Russian (Test)"
    }],
    "details": [{
        "language_code": "en",
        "language_name": "English (English)"
    }, {
        "language_code": "ru",
        "language_name": "Russian (Test)"
    }]
}
"""

// Decode JSON
do {
    let response = try
    JSONDecoder().decode(Root.self, from: json.data(using: .utf8)!)
    
    response.header?.forEach { h in
        
        print(h)

        print(h.current_language_code!)
        print(h.current_language_name!)
        
    }
    
    response.details?.forEach { d in
        
        print(d)

        print(d.language_code!)
        print(d.language_name!)
        
    }
    
    let languages = response.header
    print(languages!)
    
    
} catch let jsonErr {
    print ("Error serializing json: ", jsonErr)
}
