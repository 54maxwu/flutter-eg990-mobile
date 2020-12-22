import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // flutter channel
    // static const _rotationChannel = const MethodChannel('com.eg990.mobile/orientation');
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let rotationChannel = FlutterMethodChannel(
        name: "com.eg990.mobile/orientation",
        binaryMessenger: controller.binaryMessenger)

    // flutter call (call SystemChrome.setPreferredOrientation before invoke)
    // _rotationChannel.invokeMethod('setLandscapeLeft');
    // _rotationChannel.invokeMethod('setLandscapeRight');
    // _rotationChannel.invokeMethod('setPortrait');
    rotationChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
      guard call.method.hasPrefix("set") == true else {
        print("error method name")
        return
      }

      if "setLandscapeRight" == call.method {
        UIDevice.current.setValue(NSNumber(value: UIInterfaceOrientation.landscapeRight.rawValue), forKey: "orientation")
      } else if "setLandscapeLeft" == call.method {
        UIDevice.current.setValue(NSNumber(value: UIInterfaceOrientation.landscapeLeft.rawValue), forKey: "orientation")
      }  else if "setPortrait" == call.method {
        UIDevice.current.setValue(NSNumber(value: UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    func getConfigFlag() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let build = dictionary["ConfigFlag"] as! String
        // debug = 0, release = 1, profile = 1
        print("config flag = \(build)")
        return build
    } 
    let flag = getConfigFlag()
    if (flag == '1') {
        FirebaseApp.configure()
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
