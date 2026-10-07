import Foundation
import CoreGraphics
import ImageIO

func cropImage(inputPath: String, outputPath: String, rect: CGRect) {
    guard let inputURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, inputPath as CFString, .cfurlposixPathStyle, false),
          let imageSource = CGImageSourceCreateWithURL(inputURL, nil),
          let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else {
        print("Failed to load \(inputPath)")
        return
    }
    
    guard let cropped = image.cropping(to: rect) else {
        print("Failed to crop \(inputPath)")
        return
    }
    
    guard let outputURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, outputPath as CFString, .cfurlposixPathStyle, false),
          let destination = CGImageDestinationCreateWithURL(outputURL, "public.png" as CFString, 1, nil) else {
        print("Failed to create destination \(outputPath)")
        return
    }
    
    CGImageDestinationAddImage(destination, cropped, nil)
    CGImageDestinationFinalize(destination)
    print("Saved \(outputPath)")
}

// Alex Mascon avatar from Home.png (1500 x 3248)
// Around x=65, y=250, size roughly 170x170
cropImage(inputPath: "temp/Screens2/Home.png",
          outputPath: "assets/images/home_avatar.png",
          rect: CGRect(x: 65, y: 260, width: 170, height: 170))

// Notification bell icon from Home.png
// Around x=1265, y=260, size roughly 170x170
cropImage(inputPath: "temp/Screens2/Home.png",
          outputPath: "assets/icons/home_bell.png",
          rect: CGRect(x: 1265, y: 260, width: 170, height: 170))

