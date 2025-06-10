import 'package:calender_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:calender_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:calender_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:calender_test/features/auth/domain/usecases/login_usecase.dart';
import 'package:calender_test/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:calender_test/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// DioClient Provider
final dioClientProvider = Provider<DioClient>((ref) => DioClient());

// AuthRemoteDataSource Provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuthRemoteDataSourceImpl(dioClient);
});

// AuthRepository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});

// LoginUseCase Provider
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

// LoginViewModel Provider
// Using StateNotifierProvider for this example. AsyncNotifierProvider could also be used.
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginStatus>((ref) {
      final loginUseCase = ref.watch(loginUseCaseProvider);
      return LoginViewModel(loginUseCase);
    });
