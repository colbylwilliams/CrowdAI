//
//  Utilities.swift
//  CrowdAI
//
//  Created by Colby L Williams on 10/2/18.
//  Copyright © 2018 Colby L Williams. All rights reserved.
//

import UIKit
import MobileCoreServices

extension URL {
    
    var isImage: Bool {
        do {
            
            let typeValues = try self.resourceValues(forKeys: [.typeIdentifierKey])
            
            return typeValues.typeIdentifier != nil && UTTypeConformsTo(typeValues.typeIdentifier! as CFString, kUTTypeImage)
            
        } catch {
            print("Compass Error getting resource values for url (\(self)): \(error)")
            return false
        }
    }
}



extension NSCache where KeyType == NSString, ObjectType == UIImage {
    
    subscript(key: URL) -> UIImage? {
        get {
            return object(forKey: key.absoluteString as NSString)
        }
        set {
            if let value = newValue {
                setObject(value, forKey: key.absoluteString as NSString)
            } else {
                removeObject(forKey: key.absoluteString as NSString)
            }
        }
    }
    
//    subscript(key: Media) -> UIImage? {
//        get {
//            return object(forKey: key.url.absoluteString as NSString)
//        }
//        set {
//            if let value = newValue {
//                setObject(value, forKey: key.url.absoluteString as NSString)
//            } else {
//                removeObject(forKey: key.url.absoluteString as NSString)
//            }
//        }
//    }
}



extension UIImage {
    
    func cropToSquare() -> UIImage {
        
        let refWidth = CGFloat((self.cgImage!.width))
        let refHeight = CGFloat((self.cgImage!.height))
        let cropSize = refWidth > refHeight ? refHeight : refWidth
        
        let x = (refWidth - cropSize) / 2.0
        let y = (refHeight - cropSize) / 2.0
        
        let cropRect = CGRect(x: x, y: y, width: cropSize, height: cropSize)
        let imageRef = self.cgImage?.cropping(to: cropRect)
        let cropped = UIImage(cgImage: imageRef!, scale: 0.0, orientation: self.imageOrientation)
        
        return cropped
    }
}
