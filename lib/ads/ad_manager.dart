import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

class AdManager {
  static final AdManager _instance = AdManager._internal();
  factory AdManager() => _instance;
  AdManager._internal();

  // Banner ad instances
  BannerAd? _homeBannerAd;
  BannerAd? _cadenceBannerAd;
  BannerAd? _wattsBannerAd;

  // Interstitial ad
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  // Timer for interstitial ads
  Timer? _interstitialTimer;
  int _interstitialCounter = 0;
  static const int INTERSTITIAL_INTERVAL = 120;

  /// Initialize Google Mobile Ads SDK
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  /// Load a banner ad
  BannerAd? loadBannerAd({
    required String pageName,
    required AdSize adSize,
    required void Function() onAdLoaded,
  }) {
    BannerAd? bannerAd;

    bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: adSize,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$pageName: Banner Ad loaded.');
          onAdLoaded();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$pageName: Banner Ad failed to load: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$pageName: Banner Ad opened.'),
        onAdClosed: (Ad ad) => print('$pageName: Banner Ad closed.'),
      ),
    )..load();

    // Store reference based on page
    switch(pageName) {
      case 'home':
        _homeBannerAd = bannerAd;
        break;
      case 'cadence':
        _cadenceBannerAd = bannerAd;
        break;
      case 'watts':
        _wattsBannerAd = bannerAd;
        break;
    }

    return bannerAd;
  }

  Future<void> loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              _isInterstitialAdReady = false;
              loadInterstitialAd(); // Pre-load next interstitial
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              print('Interstitial ad failed to show: $error');
              ad.dispose();
              _isInterstitialAdReady = false;
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Interstitial ad failed to load: $error');
          _isInterstitialAdReady = false;
          // Retry after delay
          Future.delayed(const Duration(seconds: 30), loadInterstitialAd);
        },
      ),
    );
  }

  void showInterstitialAd() {
    _interstitialCounter++;

    // Show ad every INTERSTITIAL_INTERVAL seconds
    if (_interstitialCounter >= INTERSTITIAL_INTERVAL && _isInterstitialAdReady) {
      _interstitialAd?.show();
      _interstitialCounter = 0;
    }
  }

  void startInterstitialTimer() {
    _interstitialTimer?.cancel();
    _interstitialTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      showInterstitialAd();
    });
  }

  void dispose() {
    _homeBannerAd?.dispose();
    _cadenceBannerAd?.dispose();
    _wattsBannerAd?.dispose();
    _interstitialAd?.dispose();
    _interstitialTimer?.cancel();
  }
}