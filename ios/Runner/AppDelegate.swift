import Flutter
import UIKit
import NidThirdPartyLogin

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // FCM: Foreground 알림 활성화
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {

    // 1) 네이버가 처리해야 하는 URL이면 네이버로 먼저 넘기고 종료
    if NidOAuth.shared.handleURL(url) == true {
      return true
    }

    // 2) 그 외 모든 URL은 Flutter쪽(플러그인들)에게 전달 (카카오, url_launcher 등)
    if super.application(app, open: url, options: options) {
      return true
    }

    // 3) 여기까지도 아무도 처리 안 했다면 false
    return false
  }
}
