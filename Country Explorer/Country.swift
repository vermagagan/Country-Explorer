import Foundation
struct Country : Codable, Identifiable{
    let id = UUID()
    let flags : Flags
    let name: Name
    let currencies: [String : Currency]?
    let languages: [String: String]?
    let capital: [String]?
    let region: String
    let subregion: String?
    let population: Int
    
    struct Flags: Codable{
        let png: String
        let svg: String
        let alt: String?
    }
    
    struct Name: Codable{
        let common: String
        let official: String
        let nativeName: [String: NativeNameDetail]?
    }
    
    struct NativeNameDetail: Codable {
        let official: String // Fixed spelling
        let common: String
    }
    
    struct Currency: Codable{
        let name: String
        let symbol: String?
    }
    
    // Tell Codable to ignore 'id' during decoding since it's not in the JSON
    enum CodingKeys: String, CodingKey {
        case flags, name, currencies, languages, capital, region, subregion, population
    }
}
