import Foundation
import CSVReader

struct LocalizedCSVWriter
{
    typealias LanguageCSV = [StringKey : [Language:String]]
    typealias StringKey = String
    
    enum Language: String
    {
        case key = "Var"
        case eng = "EN"
        case sp = "ES"
        case pt = "PT"
        
        static var all : [Language] {
            return [.eng, .sp, .pt]
        }
    }
    
    
    static func write(csv: CSVReader.CSV, path: String) {
        guard !csv.values.isEmpty else {
            fatalError("No CSV Data Was Read")
        }
        let savePath = URL(fileURLWithPath: path).deletingPathExtension().absoluteString
        var langCSV = LanguageCSV()
        guard let varCSV = csv[Language.key.rawValue] else { return }
        varCSV.enumerated().forEach {
            (args) in
            let (index, stringKey) = args
            var translations = [Language:String]()
            for lang in Language.all {
                translations[lang] = csv[lang.rawValue]?[index] ?? "no translation"
            }
            langCSV[stringKey] = translations
        }
        for lang in Language.all {
            let dataString = langCSV.map {
                "\"\($0.key)\" = \"\($0.value[lang] ?? "")\"; \n"
                }.reduce("", +)
            
            let savePathURL = URL(fileURLWithPath: "\(savePath)_\(lang.rawValue)")
            if !write(dataString, to: savePathURL.appendingPathExtension("strings")) {
                print ("Failed Writing Localizations For - \(lang.rawValue)")
            }
        }
        
    }
    
    private static func write(_ data: String, to filePath: URL) -> Bool {
        do {
            try data.write(to: filePath, atomically: true, encoding: .utf8)
            return true
        } catch {
            print("Failed Writing File - \(error)")
            return false
        }
    }
    
}
