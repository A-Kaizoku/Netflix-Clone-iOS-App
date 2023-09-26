//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Mayank on 05/08/22.
//

import Foundation

struct Constants {
    static let API_KEY="f9446bbfaf40a3288469fa19024512c0"
    static let baseURL="https://api.themoviedb.org/"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>)->Void) {
        guard let url: URL = URL(string: "\(Constants.baseURL)3/trending/movie/week?api_key=\(Constants.API_KEY)") else {return}
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
//            let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(results)
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from:data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>)->Void) {
        
        guard let url: URL = URL(string: "\(Constants.baseURL)3/trending/tv/week?api_key=\(Constants.API_KEY)") else {return}
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from:data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>)->Void) {
    
    //https://api.themoviedb.org/3/movie/upcoming?api_key=f9446bbfaf40a3288469fa19024512c0&language=en-US&page=1
        guard let url: URL = URL(string: "\(Constants.baseURL)3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from:data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }

        }
        
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>)->Void) {
        
        guard let url: URL = URL(string: "\(Constants.baseURL)3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from:data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>)->Void) {
        
        guard let url: URL = URL(string: "\(Constants.baseURL)3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from:data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
            guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(.success(results.results))

                } catch {
                    completion(.failure(APIError.failedToGetData))
                }

            }
            task.resume()
        }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
            
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
            guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(.success(results.results))

                } catch {
                    completion(.failure(APIError.failedToGetData))
                }

            }
            task.resume()
        }
}
