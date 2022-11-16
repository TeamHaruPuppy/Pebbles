import UIKit

func saveJsonData(data:HighlightPostModel) {
    let jsonEncoder = JSONEncoder()
    
    do {
        let encodedData = try jsonEncoder.encode(data)
        print(String(data: encodedData, encoding: .utf8)!)
        
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectoryUrl.appendingPathComponent("sampleData.json")
        
        do {
            try encodedData.write(to: fileURL)
        }
        catch let error as NSError {
            print(error)
        }
        
        
    } catch {
        print(error)
    }
    
}
