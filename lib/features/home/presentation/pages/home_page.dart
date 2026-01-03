import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../../ads/ad_manager.dart';
import '../../../cadence/presentation/pages/cadence_page.dart';
import '../../../watts/presentation/pages/watts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Banner ad variables
  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;

  // Ad manager instance
  final AdManager _adManager = AdManager();

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    // Start interstitial ad timer
    _adManager.startInterstitialTimer();
  }

  void _loadBannerAd() {
    _bannerAd = _adManager.loadBannerAd(
      pageName: 'home',
      adSize: AdSize.banner,
      onAdLoaded: () {
        setState(() {
          _isBannerAdReady = true;
        });
      },
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Show interstitial ad occasionally on navigation
    if (index != _currentIndex) {
      _adManager.showInterstitialAd();
    }
  }

  List<Widget> _pages() {
    return [
      const CadencePage(),
      const WattsPage(),
    ];
  }

  final List<Color> _backgroundColors = [
    const Color.fromRGBO(134, 187, 229, 1),
    Colors.blueGrey,
  ];

  @override
  void dispose() {
    _bannerAd?.dispose();
    _adManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Expanded(child: _pages()[_currentIndex]),
          // Banner Ad (only in HomePage, not in child pages)
          if (_isBannerAdReady && _bannerAd != null)
            Container(
              height: _bannerAd!.size.height.toDouble(),
              width: _bannerAd!.size.width.toDouble(),
              color: _backgroundColors[_currentIndex],
              alignment: Alignment.center,
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
        backgroundColor: _backgroundColors[_currentIndex],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade200,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Cadence',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.electric_bolt),
            label: 'Watts',
          ),
        ],
      ),
    );
  }
}