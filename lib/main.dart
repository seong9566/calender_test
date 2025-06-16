import 'dart:async';
import 'package:calender_test/core/storage/secure_storage_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Future.wait([SecureStorageUtil.saveFcmToken("test")]);

      runApp(const ProviderScope(child: MyApp()));
    },
    (error, stackTrace) {
      print("Error: $error");
      print("Stack trace: $stackTrace");
    },
  );
}
