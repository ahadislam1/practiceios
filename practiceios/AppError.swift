

import Foundation

public enum AppError: Error {

    case badURL(String)
    case noResponse, noData
    case networkClientError(Error)
    case decodingError(Error)
    case badStatusCode(Int)
    case badMimeType(String)
}