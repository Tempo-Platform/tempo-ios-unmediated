import Foundation
import TempoSDK

public class TempoInterstitialAd: TempoAdListener{

    public let interstitialListener: InterstitialListener
    var adController: TempoAdController?
    var adReady: Bool = false
    
    public init(listener: InterstitialListener) {
        self.interstitialListener = listener
    }
    
    /// Sends request for interstitial ad content with blank placement ID, and loads if successful
    public func loadAd(cpmFloor: Float?) {
        loadAd(cpmFloor: cpmFloor, placementId: nil)
    }
    
    /// Sends request for interstitial ad content with placement ID, and loads if successful
    public func loadAd(cpmFloor: Float?, placementId: String?) {
        if(!Tempo.isInitialised) {
            Tempo.warn(msg: "TempoSDK not initialised, cannot load ads")
            return
        }
        
        if(adController == nil){
            adController = TempoAdController(tempoAdListener: self, appId: Tempo.getAppId())
        }
        adController?.loadAd(isInterstitial: true, cpmFloor: cpmFloor, placementId: placementId)
    }
    
    /// Plays loaded interstitial ad content, if ready
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
    
    /// Protocol stub for Tempo Listener, return false (not used yet)
    public func hasUserConsent() -> Bool? {
        return false
    }
    
    /// Protocol stub for Tempo Listener when ad load is successful
    public func onTempoAdFetchSucceeded(isInterstitial: Bool) {
        if(isInterstitial) {
            adReady = true
            interstitialListener.onAdLoaded()
        }
    }
    
    /// Protocol stub for Tempo Listener when ad load fails
    public func onTempoAdFetchFailed(isInterstitial: Bool, reason: String?) {
        adReady = false
        if(isInterstitial) {
            interstitialListener.onAdLoadFailed(reason: reason)
        }
    }
    
    /// Protocol stub for Tempo Listener when ad closed
    public func onTempoAdClosed(isInterstitial: Bool) {
        adReady = false
        if(isInterstitial) {
            interstitialListener.onAdClosed()
        }
    }
    
    /// Protocol stub for Tempo Listener when ad displayed
    public func onTempoAdDisplayed(isInterstitial: Bool) {
        adReady = false
        if(isInterstitial) {
            interstitialListener.onAdShow()
        }
    }
    
    /// Protocol stub for Tempo Listener when ad display fails
    public func onTempoAdShowFailed(isInterstitial: Bool, reason: String?) {
        adReady = false
        if(isInterstitial) {
            interstitialListener.onAdShowFailed(reason: reason)
        }
    }
    
    /// Protocol stub for Tempo Listener when ad clicked (unused)
    public func onTempoAdClicked(isInterstitial: Bool) {
        adReady = false
        if(isInterstitial) {
            //interstitialListener.onAdClick()
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
}
