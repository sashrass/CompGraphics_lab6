import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var widthField: NSTextField!
    @IBOutlet weak var heightField: NSTextField!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
         
        srand48(time(nil))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
         
    }
    
     
    func imageFromPixels(width: Int, height: Int, pixels: [Pixel]) -> NSImage {
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo:CGBitmapInfo = CGBitmapInfo.byteOrder32Little
        let bitsPerComponent = 8
        let bitsPerPixel = 4 * bitsPerComponent
        let bytesPerRow = bitsPerPixel * width / 8
        let providerRef = CGDataProvider(
            data: NSData(bytes: pixels, length: height * bytesPerRow)
        )
        
        let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: bytesPerRow,
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo,
            provider: providerRef!,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )
        return NSImage(cgImage: cgim!, size: CGSize(width: width, height: height))
        
    }
    
    @IBAction func start(sender: AnyObject) {
        let width = widthField.integerValue
        let height = heightField.integerValue

        let pixels = rayTrace(width: width, height: height)
        
        let image = imageFromPixels(width: width, height: height, pixels: pixels)
        
        imageView.image = image
        
    }


}

