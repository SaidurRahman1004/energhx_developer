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

cropImage(inputPath: "temp/Screens2/Setting.png",
          outputPath: "assets/images/user_avatar.png",
          rect: CGRect(x: 620, y: 505, width: 260, height: 260))

cropImage(inputPath: "temp/Screens2/Programs.png",
          outputPath: "assets/images/solar_banner.png",
          rect: CGRect(x: 68, y: 436, width: 1364, height: 630))

cropImage(inputPath: "temp/Screens2/Programs.png",
          outputPath: "assets/images/wind_banner.png",
          rect: CGRect(x: 68, y: 1500, width: 1364, height: 630))

cropImage(inputPath: "temp/Screens2/Programs.png",
          outputPath: "assets/images/biomass_banner.png",
          rect: CGRect(x: 68, y: 2560, width: 1364, height: 630))

cropImage(inputPath: "temp/Screens2/Details.png",
          outputPath: "assets/images/power_course.png",
          rect: CGRect(x: 68, y: 510, width: 654, height: 360))
