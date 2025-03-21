import Foundation
import TempoSDK

public class TempoRewardedAd: TempoAdListener {
        
    public let rewardedListener: RewardedListener
    var adController: TempoAdController?
    var adReady: Bool = false
    
    public init(listener: RewardedListener) {
        self.rewardedListener = listener
    }
    
    /// Sends request for rewarded ad content with blank placement ID, and loads if successful
    public func loadAd(cpmFloor: Float?) {
        loadAd(cpmFloor: cpmFloor, placementId: nil)
    }
    
    /// Sends request for rewarded ad content with placement ID, and loads if successful
    public func loadAd(cpmFloor: Float?, placementId: String?) {
        if(!Tempo.isInitialised) {
            Tempo.warn(msg: "TempoSDK not initialised, cannot load ads")
            return
        }
        
        if(adController == nil){
            adController = TempoAdController(tempoAdListener: self, appId: Tempo.getAppId())
        }
        adController?.loadAd(isInterstitial: false, cpmFloor: cpmFloor, placementId: placementId)
    }
    
    /// Plays loaded rewarded ad content, if ready
    public func showAd(vc: UIViewController) {
        if(!Tempo.isInitialised) {
            Tempo.warn(msg: "TempoSDK not initialised, cannot show ads")
            return
        }
        if(!adReady) {
            Tempo.warn(msg: "Ad not ready to be shown")
            return
        }
        
        adController?.showAd(parentViewController: vc)
    }
    
    /// Returns true if loaded ad content is ready
    public func isAdReady() -> Bool {
        return adReady
    }
    
    /// Protocol stub for Tempo Listener when ad load is successful
    public func onTempoAdFetchSucceeded(isInterstitial: Bool) {
        if(!isInterstitial) {
            adReady = true
            rewardedListener.onAdLoaded()
        }
    }
    
    /// Protocol stub for Tempo Listener when ad load fails
    public func onTempoAdFetchFailed(isInterstitial: Bool, reason: String?) {
        adReady = false
        if(!isInterstitial) {
            rewardedListener.onAdLoadFailed(reason: reason)
        }
    }
    
    /// Protocol stub for Tempo Listener when ad closed
    public func onTempoAdClosed(isInterstitial: Bool) {
        adReady = false
        if(!isInterstitial) {
            rewardedListener.onAdClosed()
            rewardedListener.onAdRewarded()
        }
    }
    
    /// Protocol stub for Tempo Listener when ad displayed
    public func onTempoAdDisplayed(isInterstitial: Bool) {
        adReady = false
        if(!isInterstitial) {
            rewardedListener.onAdShow()
        }
    }
    
    /// Protocol stub for Tempo Listener when ad display fails
    public func onTempoAdShowFailed(isInterstitial: Bool, reason: String?) {
        adReady = false
        if(!isInterstitial) {
            rewardedListener.onAdShowFailed(reason: reason)
        }
    }
    
    /// Protocol stub for Tempo Listener when ad clicked (unused)
    public func onTempoAdClicked(isInterstitial: Bool) {
        adReady = false
        if(!isInterstitial) {
            //rewardedListener.onAdClick()
        }
    }
    
    /// Returns this asdapters release version
    public func getTempoAdapterVersion() -> String? {
        return Tempo.VERSION
    }
    
    /// Returns this adapters type (UNMEDIATED)
    public func getTempoAdapterType() -> String? {
        return Tempo.ADAPTER_TYPE
    }
    
    /// Protocol stub for Tempo Listener, return false (not used yet)
    public func hasUserConsent() -> Bool? {
        return false
    }
}
