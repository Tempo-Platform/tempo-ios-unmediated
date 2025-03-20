import Foundation

public protocol InterstitialListener {
    
    func onAdLoaded()
    
    func onAdLoadFailed(reason: String?)
    
    func onAdShow()
    
    func onAdClosed()
    
    func onAdClick()
    
    func onAdShowFailed(reason: String?)
}
