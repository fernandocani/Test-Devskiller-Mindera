//
//  Utilities.swift
//  Devskiller
//
//  Created by Fernando Cani on 05/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

struct Utilities {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    static func loadStub<T: Decodable>(url: URL) -> T {
        do {
            let data = try Data(contentsOf: url)
            let d = try Utilities.jsonDecoder.decode(T.self, from: data)
            return d
        } catch let error as DecodingError {
            print(error.localizedDescription)
            fatalError()
        } catch {
            fatalError()
        }
    }
}
