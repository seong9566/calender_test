import 'dart:async';
import 'dart:io';
import 'package:calender_test/core/storage/secure_storage_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcp_toolkit/mcp_toolkit.dart';
import 'package:uuid/uuid.dart';

import 'app.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final uuid = const Uuid().v4();

      await Future.wait([
        SecureStorageUtil.saveFcmToken("test"),
        SecureStorageUtil.saveUuid(uuid),
      ]);

      runApp(const ProviderScope(child: MyApp()));
    },
    (error, stackTrace) {
      print("Error: $error");
      print("Stack trace: $stackTrace");
    },
  );
}
