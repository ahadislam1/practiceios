import Foundation

public class NetworkHelper {

    public static let shared = NetworkHelper()

    private var urlSession: URLSession

    private init() {
        urlSession = URLSession(configuration: .default)
    }

    public func performDataTask(with request: URLRequest, completion: @escaping (Result< Data, AppError>) -> Void) {

        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in

            if let error = error {
                completion(.failure(.networkClientError(error)))
                return
            }

            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }

            switch urlResponse.statusCode {
                case 200...299: break
                default:
                    completion(.failure(.badStatusCode(urlResponse.statusCode)))
                    return
            }

            completion(.success(data))


        }
    } 
}