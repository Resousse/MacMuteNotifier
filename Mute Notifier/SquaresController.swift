//
//  SquaresController.swift
//


import Cocoa
import SwiftUI
import Combine

class SquaresController: ObservableObject {
    static let shared = SquaresController()
    private var squareWindows: [NSWindow] = []
    @Published var squaresVisible: Bool = false {
        didSet {
            squaresVisible ? showSquares() : hideSquares()
        }
    }
    init() {

    }
    
    // Crée ou met à jour les fenêtres carrés
    @MainActor
    func refreshSquares() {
        hideSquares()
        if squaresVisible { showSquares() }
    }
    
    @MainActor
    func showSquares() {
        for screen in NSScreen.screens {
            let visibleFrame = screen.visibleFrame
            //print("Displayed square on screen:", screen.localizedName, "VisibleFrame:", visibleFrame)
            
            let size: CGFloat = 50
            let margin: CGFloat = 10
            //let x = visibleFrame.width - size - margin
            let x = 0 + margin
            let padding = visibleFrame.origin.y > 0.0 ? visibleFrame.origin.y : 0.0
            //let y = visibleFrame.height - size - margin + padding
            let y = 0 + margin
            let window = NSWindow(contentRect: NSRect(x: x, y: y, width: size, height: size),
                                  styleMask: .borderless,
                                  backing: .buffered, defer: false, screen: screen)
            
            window.isOpaque = true
            window.hasShadow = false
            window.level = .screenSaver
            window.hidesOnDeactivate = false;
            window.collectionBehavior = [.canJoinAllSpaces, .stationary, .fullScreenAuxiliary]
            window.backgroundColor = .clear
            window.ignoresMouseEvents = true
            
            let window1 = NSWindow(contentRect: NSRect(x: visibleFrame.width - size - margin, y: y, width: size, height: size),
                                  styleMask: .borderless,
                                  backing: .buffered, defer: false, screen: screen)
            
            window1.isOpaque = true
            window1.hasShadow = false
            window1.level = .screenSaver
            window1.hidesOnDeactivate = false;
            window1.collectionBehavior = [.canJoinAllSpaces, .stationary, .fullScreenAuxiliary]
            window1.backgroundColor = .clear
            window1.ignoresMouseEvents = true
            
            let imageView = NSImageView(frame: NSRect(origin: .zero, size: NSSize(width: size, height: size)))
            imageView.wantsLayer = true // Important pour utiliser layer
            imageView.layer?.backgroundColor = CGColor(red: 1.0, green: 0, blue: 0, alpha: 1.0) // rouge opaque

            if let muteImage = NSImage(systemSymbolName: "speaker.slash.fill", accessibilityDescription: "Mute icon") {
                imageView.image = muteImage
                imageView.contentTintColor = .white // icône blanche
                imageView.imageScaling = .scaleProportionallyUpOrDown
            }
            
            let imageView1 = NSImageView(frame: NSRect(origin: .zero, size: NSSize(width: size, height: size)))
            imageView1.wantsLayer = true // Important pour utiliser layer
            imageView1.layer?.backgroundColor = CGColor(red: 1.0, green: 0, blue: 0, alpha: 1.0) // rouge opaque

            if let muteImage1 = NSImage(systemSymbolName: "speaker.slash.fill", accessibilityDescription: "Mute icon") {
                imageView1.image = muteImage1
                imageView1.contentTintColor = .white // icône blanche
                imageView1.imageScaling = .scaleProportionallyUpOrDown
            }

            
            /*let redView = NSView(frame: NSRect(origin: .zero, size: NSSize(width: size, height: size)))
            redView.wantsLayer = true
            redView.layer?.backgroundColor = NSColor.red.cgColor
            redView.contentView = imageView*/
            
            window.contentView = imageView
            window1.contentView = imageView1
            NSApplication.shared.activate(ignoringOtherApps: true)
            window.orderFrontRegardless()
            window1.orderFrontRegardless()

            squareWindows.append(window)
            squareWindows.append(window1)
        }
    }
    
    // Masque les fenêtres carrés
    @MainActor
    func hideSquares() {
        for win in squareWindows {
            win.orderOut(nil)
        }
        squareWindows.removeAll()
    }
}
