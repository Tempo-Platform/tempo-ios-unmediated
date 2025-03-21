import Foundation

public protocol TempoInitListener {
    
    func onTempoInitialized()
    
    func onTempoInitializationFailed(errorMsg: String)
}
