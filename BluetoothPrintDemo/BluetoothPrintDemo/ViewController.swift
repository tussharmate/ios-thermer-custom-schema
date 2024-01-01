//
//  ViewController.swift
//  BluetoothPrintDemo
//
//  Created by AppDeveloper on 3/12/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onSamplePrintButtonTap(_ sender: Any) {
        
        var entries = [Int: PrintEntry]()
        
        // Sending text entry
        entries[0] = PrintEntry(type: 0, content: "My Title", bold: 1, align: 2, format: 3)
        
        // Sending image entry
        
        ///For URL
        //        entries[1] = PrintEntry(type: 1, align: 2, path: "https://www.mydomain.com/image.jpg")
        
        ///For Image Data
        if let yourImage = UIImage(named: "dummy") { // Replace with your image
            
            if let base64String = self.convertImageToBase64String(img: yourImage) {
                entries[1] = PrintEntry(type: 1, align: 2, base64Image: base64String)
            } else {
                print("Failed to convert image to base64 string.")
            }
        }
        
        // Sending barcode entry
        entries[2] = PrintEntry(type: 2, align: 0, value: "1234567890123", height: 50)
        
        // Sending QR entry
        entries[3] = PrintEntry(type: 3, align: 2, value: "sample qr text", size: 40)
        
        // Sending empty line
        entries[4] = PrintEntry(type: 0, content: " ", bold: 0, align: 0)
        
        // Sending multi-lines text
        entries[5] = PrintEntry(type: 0, content: "This text has<br />two lines", bold: 0, align: 0)
        
        do {
            let jsonData = try JSONEncoder().encode(entries)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let urlEncoadedJson = jsonString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                let url = URL(string: "thermer://?data=\(urlEncoadedJson!)")
                UIApplication.shared.open(url!)
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
    }
    
    func imageToBase64(image: UIImage, compressionQuality: CGFloat = 1.0) -> String? {
        if let imageData = image.jpegData(compressionQuality: compressionQuality) {
            return imageData.base64EncodedString(options: .lineLength64Characters)
        }
        return nil
    }
    
    func convertImageToBase64String (img: UIImage) -> String? {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> Data? {
        let imageData = Data(base64Encoded: imageBase64String)
        return imageData
    }
}

struct PrintEntry: Codable {
    var type: Int
    var content: String?
    var bold: Int?
    var align: Int?
    var format: Int?
    var path: String?
    var value: String?
    var height: Int?
    var size: Int?
    var base64Image: String?
}
