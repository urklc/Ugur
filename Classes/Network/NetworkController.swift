/*
The MIT License (MIT)

Copyright (c) 2020 Ugur Kilic All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

import Foundation

open class NetworkController {

    public var host: String
    public var sharedHeaders: [String: String]
    private let customErrorBlock: ((Data) -> UgurError?)?

    public init(host: String,
                sharedHeaders: [String: String]?,
                customErrorBlock: ((Data) -> UgurError)? = nil) {
        self.host = host
        self.sharedHeaders = sharedHeaders ?? [:]
        self.customErrorBlock = customErrorBlock
    }

	public func send(request: Request) async throws {
		try await withCheckedThrowingContinuation({ (c: CheckedContinuation<Void, Error>)  in
			send(request: request) { error in
				if let error = error {
					c.resume(throwing: error)
				} else {
					c.resume()
				}
			}
		})
	}

	public func send<T: Decodable>(request: Request) async throws -> T {
		try await withCheckedThrowingContinuation({ continuation  in
			send(request: request) { (object: T?, error) in
				if let object = object {
					continuation.resume(returning: object)
				} else if let error = error {
					continuation.resume(throwing: error)
				}
			}
		})
	}

	@available(*, deprecated, renamed: "send(request:)")
    public func send(request: Request, completion: @escaping (UgurError?) -> Void) {
        let urlRequest = NetworkController.createURLReqest(
            host: host,
            sharedHeaders: sharedHeaders,
            request: request)

        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                if let code = (response as? HTTPURLResponse)?.statusCode {
                    if code < 200 || code > 299 {
                        completion(.unexpected)
                        return
                    }
                }
                completion(strongSelf.createError(data: data, error: error))
            }
        }
        task.resume()
    }

	@available(*, deprecated, renamed: "send(request:)")
    public func send<T: Decodable>(request: Request,
                                   completion: @escaping (T?, UgurError?) -> Void) {
        let urlRequest = NetworkController.createURLReqest(
            host: host,
            sharedHeaders: sharedHeaders,
            request: request)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                if let data = data,
                    let model = try? JSONDecoder().decode(T.self, from: data) {
                    completion(model, nil)
                    return
                }
                completion(nil, strongSelf.createError(data: data, error: error))
            }
        }
        task.resume()
    }
}

private extension NetworkController {

    func createError(data: Data?, error: Error?) -> UgurError? {
        if let error = error {
            return .network(error)
        }
        guard let data = data else {
            return nil
        }
        guard let serviceError = customErrorBlock?(data) else {
            return nil
        }
        return serviceError
    }

    static func createURLReqest(host: String,
                                sharedHeaders: [String: String],
                                request: Request) -> URLRequest {
        let path: String
        if let endpoint = request.endpoint {
            path = endpoint.path.appending(request.pathComponent)
        } else {
            path = request.pathComponent
        }

        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = request.queryItemProviders?.flatMap { $0.queryItems }

        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = request.httpMethod

        var headers = sharedHeaders
        if let body = request.body {
            urlRequest.httpBody = body
            headers["Content-Type"] = "application/json"
        }
        urlRequest.allHTTPHeaderFields = headers

        return urlRequest
    }
}
