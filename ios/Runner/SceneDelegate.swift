import Flutter
import NidThirdPartyLogin
import UIKit

class SceneDelegate: FlutterSceneDelegate {
  override func scene(
    _ scene: UIScene,
    openURLContexts URLContexts: Set<UIOpenURLContext>
  ) {
    // 네이버 로그인 콜백은 네이버 SDK가 먼저 처리한다.
    let remaining = URLContexts.filter { NidOAuth.shared.handleURL($0.url) != true }
    if remaining.isEmpty { return }

    // 그 외 URL(카카오, url_launcher 등)은 Flutter 플러그인에 전달한다.
    super.scene(scene, openURLContexts: remaining)
  }
}
