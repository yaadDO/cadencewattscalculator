import 'package:cadenceandwattscalc/app.dart';
import 'package:cadenceandwattscalc/themes/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ads/ad_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AdManager().initialize();
  AdManager().loadInterstitialAd();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

