import Foundation
class NetworkManager{
    static let shared = NetworkManager()
    private init() {}
    
    func fetchCountries(completion: @escaping(Result<[Country], Error>) -> Void){
        let url = URL(string: "https://restcountries.com/v3.1/all?fields=name,capital,population,flags,region,subregion,languages,currencies")!
        
        URLSession.shared.dataTask(with: url){ data, _, error in
            
            if let error = error{
                completion(.failure(error))
                return
            }
            
            guard let data = data else{return}
            
            do{
                let countries = try JSONDecoder().decode([Country].self,from: data)
                completion(.success(countries))
            }
            catch{
                completion(.failure(error))
            }
            
        }.resume()
    }
}
