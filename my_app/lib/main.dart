import 'package:acr_cloud_sdk_example/utils/log.dart';
import 'package:acr_cloud_sdk_example/views/fav_song.dart';
import 'package:acr_cloud_sdk_example/views/home_page.dart';
import 'package:acr_cloud_sdk_example/views/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Log.init(kReleaseMode);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    overrideDeviceColors();
    return MaterialApp(
      title: 'See A Song',
      debugShowCheckedModeBanner: false,
      theme: themeData(context),
      home: SignInPage(),
    );
  }
}
