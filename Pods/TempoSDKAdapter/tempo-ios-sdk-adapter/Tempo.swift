import Foundation
import TempoSDK

public class Tempo {
    
    public static let VERSION = "1.1.0"
    public static let ADAPTER_TYPE = "UNMEDIATED"
    internal static var isInitialised: Bool = false
    private static var appId: String?;
    
    public static func testMe(msg: String) {
        print("AdapterUtils: \(msg)");
    }
    
    public static func initTempo(appId: String?, listener: TempoInitListener) {
        //TempoProfile.DisableProfile() // TODO: Add to original SDK
//        public static func DisableProfile() {
//            TempoProfile.locationState = LocationState.DISABLED
//        }
        
        if setAppId(appId: appId) {
            isInitialised = true
            listener.onTempoInitialized()
        } else {
            say(msg: "App ID is nil or empty")
            isInitialised = false
            listener.onTempoInitializationFailed(errorMsg: "App ID is nil or empty")
        }
    }
    
    public static func getAppId() -> String? {
        if let id = self.appId, !id.isEmpty {
            say(msg: "Updating App ID: \(id)")
            return self.appId
        } else {
            say(msg: "App ID is nil or empty")
            return nil
        }
    }
    
    private static func setAppId(appId: String?) -> Bool {
        if let id = appId, !id.isEmpty {
            self.appId = id
            return true
        } else {
            say(msg: "App ID cannot be nil or empty")
            return false
        }
    }
    
    /// Log for general output
    internal static func say(msg: String) {
        print("TempoAdapter: \(msg)");
    }
    
    /// Log for warning output
    internal static func warn(msg: String) {
        print("⚠️ TempoAdapter: \(msg)");
    }
}
