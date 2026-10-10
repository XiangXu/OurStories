import AppKit

let size = 1024
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: size, pixelsHigh: size, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
rep.size = NSSize(width: size, height: size)
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)

let rect = NSRect(x: 0, y: 0, width: size, height: size)
let gradient = NSGradient(colors: [
    NSColor(red: 0.96, green: 0.55, blue: 0.56, alpha: 1),
    NSColor(red: 0.85, green: 0.33, blue: 0.43, alpha: 1),
    NSColor(red: 0.70, green: 0.22, blue: 0.38, alpha: 1)
])!
gradient.draw(in: rect, angle: -60)

// Soft highlight in the top-left corner.
let glow = NSGradient(colors: [NSColor.white.withAlphaComponent(0.28), NSColor.white.withAlphaComponent(0)])!
glow.draw(in: NSBezierPath(rect: rect), relativeCenterPosition: NSPoint(x: -0.5, y: 0.6))

func symbol(_ name: String, pointSize: CGFloat, color: NSColor) -> NSImage {
    let config = NSImage.SymbolConfiguration(pointSize: pointSize, weight: .semibold)
        .applying(NSImage.SymbolConfiguration(paletteColors: [color]))
    return NSImage(systemSymbolName: name, accessibilityDescription: nil)!.withSymbolConfiguration(config)!
}

func draw(_ image: NSImage, centeredAt center: NSPoint, shadow: Bool) {
    if shadow {
        let s = NSShadow()
        s.shadowColor = NSColor(red: 0.35, green: 0.05, blue: 0.15, alpha: 0.35)
        s.shadowBlurRadius = 40
        s.shadowOffset = NSSize(width: 0, height: -18)
        s.set()
    }
    let sz = image.size
    image.draw(in: NSRect(x: center.x - sz.width / 2, y: center.y - sz.height / 2, width: sz.width, height: sz.height))
}

let book = symbol("book.pages.fill", pointSize: 430, color: .white)
draw(book, centeredAt: NSPoint(x: 512, y: 470), shadow: true)
NSShadow().set()
let heart = symbol("heart.fill", pointSize: 190, color: NSColor(red: 1.0, green: 0.93, blue: 0.9, alpha: 1))
draw(heart, centeredAt: NSPoint(x: 512, y: 800), shadow: true)

NSGraphicsContext.restoreGraphicsState()
try! rep.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
