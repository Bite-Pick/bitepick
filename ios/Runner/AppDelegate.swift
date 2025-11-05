import Flutter
import UIKit
import NidThirdPartyLogin
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override func application(
    _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    if NidOAuth.shared.handleURL(url) == true {  // If the URL was passed from the Naver app
      return true
    }
    // Handle URLs coming from other apps
    return false
  }
}
