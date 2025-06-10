import 'dart:io';
import 'package:calender_test/core/storage/secure_storage_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  // await Firebase.initializeApp();

  // FCM 토큰 요청
  // final fcmToken = await FirebaseMessaging.instance.getToken();

  // 이용자 식별자 uuid
  final uuid = const Uuid().v4();

  // Device OS 확인
  final deviceOS = Platform.isIOS ? "iOS" : "AOS";

  // SecureStorage에 저장
  await Future.wait([
    SecureStorageUtil.saveDeviceOS(deviceOS),
    // if (fcmToken != null) SecureStorageUtil.saveFcmToken(""),
    SecureStorageUtil.saveFcmToken("test"),
    SecureStorageUtil.saveUuid(uuid),
  ]);

  runApp(const ProviderScope(child: MyApp()));
}
