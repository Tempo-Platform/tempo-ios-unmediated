//
//  ViewController.swift
//  tempo-ios-unmediated
//
//  Created by Stephen Baker on 20/3/2025.
//

import UIKit
import TempoSDKAdapter
import TempoSDK

class ViewController: UIViewController, TempoInitListener, InterstitialListener, RewardedListener {

    let appId = "8"
    var interstitialAd: TempoInterstitialAd?
    var rewardedAd: TempoRewardedAd?
    
    @IBAction func intLoadBtnAction(_ sender: Any) {
        interstitialAd?.loadAd(cpmFloor: 25.0)
    }
    
    @IBAction func intPlayBtnAction(_ sender: Any) {
        if(self.interstitialAd?.isAdReady() ?? false){
            self.interstitialAd?.showAd(vc: self)
        }
    }
    
    @IBAction func rewLoadBtnAction(_ sender: Any) {
        rewardedAd?.loadAd(cpmFloor: 25.0)
    }
    
    @IBAction func rewPlayBtnAction(_ sender: Any) {
        if(self.rewardedAd?.isAdReady() ?? false){
            self.rewardedAd?.showAd(vc: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tempo.initTempo(appId: appId, listener: self)
    }
    
    func onTempoInitialized() {
        AppUtils.say(msg: "Inititalised")
        interstitialAd = TempoInterstitialAd(listener: self)
        rewardedAd = TempoRewardedAd(listener: self)
    }
    
    func onTempoInitializationFailed(errorMsg: String) {
        AppUtils.say(msg: "Inititalisation failed: \(errorMsg)")
    }
    
    func onAdLoaded() {
        AppUtils.say(msg: "onAdLoaded")
    }
    
    func onAdLoadFailed(reason: String?) {
        AppUtils.say(msg: "onAdLoadFailed")
    }
    
    func onAdShow() {
        AppUtils.say(msg: "onAdShow")
    }
    
    func onAdClosed() {
        AppUtils.say(msg: "onAdClosed")
    }
    
    func onAdClick() {
        AppUtils.say(msg: "onAdClick")
    }
    
    func onAdShowFailed(reason: String?) {
        AppUtils.say(msg: "onAdShowFailed: \(reason ?? "n/a")")
    }
    
    func onAdRewarded() {
        AppUtils.say(msg: "onAdRewarded")
    }
}

