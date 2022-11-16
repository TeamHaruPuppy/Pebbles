import UIKit

extension Encodable {
    
    func encode() throws -> [String:Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed) as? [String : Any] else {
            throw NSError()
        }
        return dictionary
    }

}
