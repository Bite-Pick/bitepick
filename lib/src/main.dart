import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:magambell/src/main_app.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(const MagambellApp());
  }, (error, stackTrace) => log(error.toString()));
}
