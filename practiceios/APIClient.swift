

class GenericCoderAPI {

    static let manager = GenericCoderAPI()

    private init() {}

    func getJSON<T: Decodable>(objectiType: T.Type, with urlString: String, completionHandler: @escaping (Result<T, AppError>) -> ()) {

        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL(urlString)))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        NetworkHelper.shared.performDataTask(with: urlRequest) { result in
            switch result {
                case .failure(let error):
                completionHandler(.failure(.networkClientError(error)))
                case .success(let data):
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(model))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}