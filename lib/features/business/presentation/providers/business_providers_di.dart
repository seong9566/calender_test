import 'package:calender_test/features/business/data/datasources/business_remote_data_source.dart';
import 'package:calender_test/features/business/data/repositories/business_repository_impl.dart';
import 'package:calender_test/features/business/domain/repositories/business_repository.dart';
import 'package:calender_test/features/business/domain/usecases/get_business_locations_usecase.dart';
import 'package:calender_test/features/business/presentation/viewmodels/business_selection_viewmodel.dart';
import 'package:calender_test/network/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 데이터소스 Provider
final businessRemoteDataSourceProvider = Provider<BusinessRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BusinessRemoteDataSourceImpl(dioClient);
});

// 리포지토리 Provider
final businessRepositoryProvider = Provider<BusinessRepository>((ref) {
  final remoteDataSource = ref.watch(businessRemoteDataSourceProvider);
  return BusinessRepositoryImpl(remoteDataSource);
});

// 유스케이스 Provider
final getBusinessLocationsUseCaseProvider = Provider<GetBusinessLocationsUseCase>((ref) {
  final repository = ref.watch(businessRepositoryProvider);
  return GetBusinessLocationsUseCase(repository);
});

// 뷰모델 Provider
final businessSelectionViewModelProvider = StateNotifierProvider<BusinessSelectionViewModel, BusinessSelectionState>((ref) {
  final useCase = ref.watch(getBusinessLocationsUseCaseProvider);
  return BusinessSelectionViewModel(useCase);
});
