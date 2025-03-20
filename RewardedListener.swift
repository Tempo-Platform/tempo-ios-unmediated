import Foundation

public protocol RewardedListener {
    
    func onAdLoaded()
    
    func onAdLoadFailed(reason: String?)
    
    func onAdShow()
    
    func onAdClosed()
    
    func onAdClick()
    
    func onAdRewarded()
    
    func onAdShowFailed(reason: String?)
}
