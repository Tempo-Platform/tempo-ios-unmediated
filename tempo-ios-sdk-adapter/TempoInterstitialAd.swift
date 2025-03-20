import Foundation
import TempoSDK

public class TempoInterstitialAd: TempoAdListener{

    
        
    public let interstitialListener: InterstitialListener
    var adController: TempoAdController?
    var adReady: Bool = false
    
    public init(listener: InterstitialListener) {
        self.interstitialListener = listener
    }
    
    public func loadAd(cpmFloor: Float?) {
        loadAd(cpmFloor: cpmFloor, placementId: nil)
    }
    
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
    
    public func isAdReady() -> Bool {
        return adReady
    }
    
    public func hasUserConsent() -> Bool? {
        return false
    }
    
    public func onTempoAdFetchSucceeded(isInterstitial: Bool) {
        if(isInterstitial) {
            adReady = true
            interstitialListener.onAdLoaded()
        }
    }
    
    public func onTempoAdFetchFailed(isInterstitial: Bool, reason: String?) {
        adReady = false
        if(isInterstitial) {
            interstitialListener.onAdLoadFailed(reason: reason)
        }
    }
    
    public func onTempoAdClosed(isInterstitial: Bool) {
        adReady = false
        if(isInterstitial) {
            interstitialListener.onAdClosed()
        }
    }
    
    public func onTempoAdDisplayed(isInterstitial: Bool) {
        adReady = false
        if(isInterstitial) {
            interstitialListener.onAdShow()
        }
    }
    
    public func onTempoAdShowFailed(isInterstitial: Bool, reason: String?) {
        adReady = false
        if(isInterstitial) {
            interstitialListener.onAdShowFailed(reason: reason)
        }
    }
    
    public func onTempoAdClicked(isInterstitial: Bool) {
        adReady = false
        if(isInterstitial) {
            //interstitialListener.onAdClick()
        }
    }
    
    public func getTempoAdapterVersion() -> String? {
        return Tempo.VERSION
    }
    
    public func getTempoAdapterType() -> String? {
        return Tempo.ADAPTER_TYPE
    }
}
