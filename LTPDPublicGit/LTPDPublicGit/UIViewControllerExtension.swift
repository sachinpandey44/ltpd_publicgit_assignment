//
//  UIViewControllerExtension.swift
//  LTPDPublicGit
//
//  Created by Sachindra on 24/7/21.
//

import UIKit
import CoreImage

extension UIViewController {
    func downloadImage(atURL imageURL: URL, forSize pointSize: CGSize, scale: CGFloat) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: true] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else {
            return nil
        }
        
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downloadSampledOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                      kCGImageSourceShouldCacheImmediately: true,
                                      kCGImageSourceCreateThumbnailWithTransform: true,
                                      kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
        guard let downloadedSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downloadSampledOptions) else {
            return nil
        }
        return UIImage(cgImage: downloadedSampledImage)
    }
}
