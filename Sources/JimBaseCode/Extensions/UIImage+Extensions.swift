//
//  UIImage+Extensions.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import Foundation

import UIKit

// MARK: 文字產生QRcode

public extension UIImageView {
    
//    https://www.appcoda.com.tw/qr-code-generator-tutorial/
    
    func generateQRcode(from string: String) {
        
        let date = string.data(using: .ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(date, forKey: "inputMessage")
            // L: 7%, M: 15%, Q: 25%, H: 30%
            filter.setValue("H", forKey: "inputCorrectionLevel")
            
            if let qrImage = filter.outputImage {
                let scaleX = frame.size.width / qrImage.extent.size.width
                let scaleY = frame.size.height / qrImage.extent.size.height
                let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                
                let output = qrImage.transformed(by: transform)
                self.image = UIImage(ciImage: output)
            }
        }
    }
    
}


public extension UIImage {
    
    func resized(to targetSize: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        let widthRatio = targetSize.width / size.width
        let heightRadio = targetSize.height / size.height
        let ratio = min(widthRatio,heightRadio)
        let imageSize = CGSize(width: size.width*ratio, height: size.height*ratio)
        let rect = CGRect(x: (targetSize.width - imageSize.width) / 2.0, y: (targetSize.height - imageSize.height) / 2.0, width: imageSize.width, height: imageSize.height)
        
        UIGraphicsBeginImageContextWithOptions(targetSize, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.saveGState()
        draw(in: rect)
        context.restoreGState()
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return thumbnail
    }
}

public extension UIImage {
    
//    https://www.jianshu.com/p/1e4bc8378c36
//    https://codertw.com/ios/326034/
    
    //對圖片的長寬壓縮
    func resize(to size: CGSize) -> UIImage {
//        let isOpaque = true //不接受透明通道
//        //創建畫布  可以設置不吃透明  size 會乘上後面的比例 設置為0會依照裝置 這邊單位是px
//        UIGraphicsBeginImageContextWithOptions(size, isOpaque, 0)
        
        UIGraphicsBeginImageContext(size) //<=不管比例
        //在當前畫布進行作畫 （uikit 可以直接畫<= uikit針對當前的畫布動作）
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        //取得畫布上的image
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        // c語言 釋放當前畫布
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
    //對圖片品質進行壓縮     再步行直接換壓縮方式
    func compressImageQuality(maxLength: Int) -> Data? {
        
        var compression: CGFloat = 1
        guard var data = self.jpegData(compressionQuality: compression) else { return nil }
        
        while (data.count > maxLength && compression > 0){
            
            compression -= 0.1;
            data = self.jpegData(compressionQuality: compression) ?? Data()
        }
        //只是為了擋掉  ?? Data()
        guard data.count != 0 else { return nil }
        
        return data
    }
    
    
    func dataCompressTo(resize: CGSize, expectedSizeInMb: Int = 3) -> Data? {
        
//        print("resize: \(resize)")
        
        guard let rawSize = self.jpegData(compressionQuality: 1)?.count else { return nil }
//        print("rawSize: \(rawSize)")
        
        // x MB
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        
        guard rawSize > sizeInBytes else { return nil }
        
        let image = self.resize(to: resize)
        // jpg壓縮 1是最高品質 圖片資料大小
        guard let resizeData = image.jpegData(compressionQuality: 1) else { return nil }
        let resizeDataSize = resizeData.count
        
//        print("resizeDataSize: \(resizeDataSize)")
        
        guard resizeDataSize > sizeInBytes else { return resizeData }
        guard let compressDate = UIImage(data: resizeData)?.compressImageQuality(maxLength: expectedSizeInMb) else { return resizeData }
//        print("compressDate: \(compressDate.count)")
        
        return compressDate
    }
    
    
}

//extension UIImage {
//
//    func scale(to size: CGSize) -> UIImage {
//        let isOpaque = false
//        UIGraphicsBeginImageContextWithOptions(size, isOpaque, 0)
//        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return scaledImage!
//    }
//
//    /**
//     Compress image size to limitation
//
//     - returns: compressed image data
//     */
//    func dataCompressToRef(_ expectedSizeInMb: Int) -> Data? {
//        var resizeImage: UIImage = self
//        // scale image size width & height smaller than 1024 px
//        let px = (1024 / UIScreen.main.scale)
//
//        var targetSize = CGSize(width: px, height: px);
//        let widthRatio  = targetSize.width  / resizeImage.size.width
//        let heightRatio = targetSize.height / resizeImage.size.height
//
//        // Figure out what our orientation is, and use that to form the rectangle
//        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
//        } else {
//            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//        }
//
//        var rect = CGSize(width: newSize.width, height: newSize.height)
//
//
//        /* if resizeImage.size.width > px {
//         resizeImage = resizeImage.scale(to: CGSize(width: px, height: px * resizeImage.size.height / resizeImage.size.width))
//         }
//         if resizeImage.size.height > px {
//         resizeImage = resizeImage.scale(to: CGSize(width: px * resizeImage.size.width / resizeImage.size.height, height: px))
//         } */
//
//
//        resizeImage = resizeImage.scale(to: rect)
////        log.info("resizeImage width is \(resizeImage.size.width)")
////        log.info("resizeImage height is \(resizeImage.size.height)")
//
//
//        let sizeInBytes = expectedSizeInMb * 1024 * 1024
//
////        let originData = resizeImage.pngData()
//        let originData = resizeImage.jpegData(compressionQuality: 1)
//        let originDataSize = originData?.count
////        log.info("OriginData size is \(String(describing: originDataSize))")
//
//        // choose 400 is for size smaller than 4MB
//        var targetHeight = 400
//        var targetWidth = 400
//
//        var biggerSize = false
//
//        if originDataSize! > sizeInBytes {
//            biggerSize = true
//            /* loggingPrint("Image size is too big")
//             loggingPrint("Image.size.height is \(resizeImage.size.height)")
//             loggingPrint("Image.size.width is \(resizeImage.size.width)")
//
//             if resizeImage.size.height > resizeImage.size.width {
//             targetWidth = Int(aspectRatio * resizeImage.size.height)
//             targetHeight = 400
//             } else {
//             targetHeight = Int(resizeImage.size.width / aspectRatio)
//             targetWidth = 400
//             } */
//        }
//        guard biggerSize else {
//            return originData
//        }
//
//        var needCompress:Bool = true
//        var imgData:Data?
//        /* var compressingValue:CGFloat = 1.0
//         let scaleImage = resizeImage.scale(to: CGSize(width: targetWidth, height: targetHeight))
//
//         while (needCompress && compressingValue > 0.0) {
//         let targetCompressImage = biggerSize ? scaleImage : resizeImage
//
//         if let data:Data = UIImageJPEGRepresentation(targetCompressImage, compressingValue) {
//         if data.count < sizeInBytes {
//         needCompress = false
//         imgData = data
//         } else {
//         compressingValue -= 0.1
//         }
//         }
//         } */
//
//
//
//        var scaleImage = resizeImage.scale(to: rect)
////        imgData = scaleImage.pngData()
//        imgData = scaleImage.jpegData(compressionQuality: 1)
//
////        log.info("Original imageData size is \(String(describing: imgData?.count))")
////        log.info("Original size is \(rect.width), \(rect.width)")
//        var scaleFactor: CGFloat = 1.0
//        while(imgData!.count > sizeInBytes){
//            scaleFactor = scaleFactor - 0.1
//            let newRect = CGSize(width: rect.width * scaleFactor, height: rect.height * scaleFactor)
//            scaleImage = resizeImage.scale(to: newRect)
//            //scaleImage = resizeImage.resizeImage(resizeImage!, scale: scaleFactor)
////            imgData = scaleImage.pngData()
//            imgData = scaleImage.jpegData(compressionQuality: 1)
////            log.info("New size is \(newRect.width), \(newRect.width)")
//        }
//
////        log.info("Return imageData size is \(String(describing: imgData?.count))")
//        return imgData
//    }
//
//}
