//
//  AppDelegate.swift



import Cocoa
import SwiftUI
import Combine
import SimplyCoreAudio

/*
let simplyCA = SimplyCoreAudio()
let device = simplyCA.defaultInputDevice
let channelNum = device?.channels(scope: .input)
Text(device?.description ?? "Hello World")
Text(String(device?.isMainChannelMuted(scope: .input) ?? false))*/

@main
struct MyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings {
            ContentView().environmentObject(SquaresController.shared)
        }
    }
}


class AppDelegate: NSObject, NSApplicationDelegate {
    //var window: NSWindow!
    var squaresController: SquaresController!
    let simplyCA = SimplyCoreAudio()
    var defaultInputDeviceObserver: NSObjectProtocol? = nil
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Crée la fenêtre principale SwiftUI
        /*let contentView = ContentView()
            .environmentObject(SquaresController.shared)
        
        window = NSWindow(contentRect: NSRect(x: 100, y: 100, width: 300, height: 120),
                          styleMask: [.titled, .closable, .miniaturizable, .resizable],
                          backing: .buffered, defer: false)
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)*/

        self.muteChanged(Notification(name: Notification.Name(rawValue: "osef"), object: self.simplyCA.defaultInputDevice))
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(screenChanged),
                                               name: NSApplication.didChangeScreenParametersNotification,
                                               object: nil)
        
        self.defaultInputDeviceObserver = NotificationCenter.default.addObserver(forName: .deviceMuteDidChange,
                                                                                 object: self.simplyCA.defaultInputDevice,
                                                                                 queue: .main) { (notification) in
            self.muteChanged(notification)
                         }
        
        NotificationCenter.default.addObserver(forName: .defaultInputDeviceChanged, object: nil, queue: .main) { notification in
            if (self.defaultInputDeviceObserver != nil) {
                NotificationCenter.default.removeObserver(self.defaultInputDeviceObserver)
            }
            self.defaultInputDeviceObserver = NotificationCenter.default.addObserver(forName: .deviceMuteDidChange,
                                                                                     object: self.simplyCA.defaultInputDevice,
                                                                                     queue: .main) { (notification) in
                self.muteChanged(notification)
                             }
        }
    }
    
    @objc func screenChanged() {
        SquaresController.shared.refreshSquares()
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        if let token = defaultInputDeviceObserver {
            NotificationCenter.default.removeObserver(token)
            defaultInputDeviceObserver = nil
        }
    }
    
    func muteChanged(_ notification: Notification){
        let audioDevice = notification.object as? AudioDevice
        if (audioDevice != nil && audioDevice!.isMainChannelMuted(scope: .input)!)
        {
            SquaresController.shared.showSquares()
        }
        else{
            SquaresController.shared.hideSquares() 
        }
    
    }
}
