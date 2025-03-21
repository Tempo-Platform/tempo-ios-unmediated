import Foundation

public protocol RewardedListener {
    
    func onAdLoaded()
    
    func onAdLoadFailed(reason: String?)
    
    func onAdShow()
    
    func onAdClosed()
    
    func onAdRewarded()
    
    func onAdShowFailed(reason: String?)
}
