import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:magambell/src/main_app.dart';

Future<void> runMagamBellApp() async {
  // WidgetsFlutterBinding.ensureInitialized();

  await runZonedGuarded<Future<void>>(() async {
    await dotenv.load(fileName: '.env');

    runApp(const MagambellApp());
  }, (error, stackTrace) => log(error.toString()));
}
