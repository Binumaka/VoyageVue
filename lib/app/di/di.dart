import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyagevue/app/shared_prefs/token_shared_prefs.dart';
import 'package:voyagevue/core/network/api_service.dart';
import 'package:voyagevue/core/network/hive_service.dart';
import 'package:voyagevue/features/accommodation/data/data_source/remote_data_source/accommodation_remote_datasource.dart';
import 'package:voyagevue/features/accommodation/data/repository/remote_repository/accommodation_remote_repository.dart';
import 'package:voyagevue/features/accommodation/domain/usecase/get_accommodation_by_destination_usecase.dart';
import 'package:voyagevue/features/accommodation/presentation/view_model/bloc/accommodation_bloc.dart';
import 'package:voyagevue/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:voyagevue/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:voyagevue/features/auth/data/repository/auth_local_repository.dart';
import 'package:voyagevue/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:voyagevue/features/auth/domain/usecase/login_usecase.dart';
import 'package:voyagevue/features/auth/domain/usecase/register_usecase.dart';
import 'package:voyagevue/features/auth/domain/usecase/upload_image_usecase.dart';
import 'package:voyagevue/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:voyagevue/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:voyagevue/features/dashboard/presentation/view_model/home_cubit.dart';
import 'package:voyagevue/features/destination/data/data_source/remote_data_source/destination_remote_data_source.dart';
import 'package:voyagevue/features/destination/data/repository/destionation_remote_repository.dart';
import 'package:voyagevue/features/destination/domain/usecase/get_all_destination_usecase.dart';
import 'package:voyagevue/features/destination/domain/usecase/get_destiantion_by_id.dart';
import 'package:voyagevue/features/destination/domain/usecase/get_destination_by_category_usecase.dart';
import 'package:voyagevue/features/destination/domain/usecase/get_destinationbyid_usecase.dart';
import 'package:voyagevue/features/destination/presentation/view_model/bloc/destination_bloc.dart';
import 'package:voyagevue/features/guide/data/data_source/remote_datasource/guide_remote_data_source.dart';
import 'package:voyagevue/features/guide/data/repository/guide_remote_repository.dart';
import 'package:voyagevue/features/guide/domain/usecase/get_all_guide_usecase.dart';
import 'package:voyagevue/features/guide/presentation/view_model/bloc/guide_bloc.dart';
import 'package:voyagevue/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:voyagevue/profile/domain/usecase/get_current_user_usecase.dart';
import 'package:voyagevue/profile/presentation/view_model/bloc/profile_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initDestinationDependencies();
  await _initAccommodationDependencies();
  await _initGuideDependencies();
  await _initProfileDependencies();

  await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDatasource(getIt<HiveService>()),
  );

  // init remote data source
  getIt.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      getIt<Dio>(),
    ),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDatasource>()),
  );

  // init remote repository
  getIt.registerLazySingleton(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // register use usecase
  // getIt.registerLazySingleton<RegisterUseCase>(
  //   () => RegisterUseCase(
  //     getIt<AuthLocalRepository>(),
  //   ),
  // );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initDestinationDependencies() {
  // ==================Data Source =================//
  getIt.registerLazySingleton<DestinationRemoteDataSource>(
    () => DestinationRemoteDataSource(
      getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================
  getIt.registerLazySingleton<DestinationRemoteRepository>(
    () => DestinationRemoteRepository(getIt<DestinationRemoteDataSource>()),
  );

  // =========================== Usecase ===========================
  getIt.registerLazySingleton<GetAllDestinationsUseCase>(
    () => GetAllDestinationsUseCase(
        destinationRepository: getIt<DestinationRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetDestinationByIdUseCase>(
    () => GetDestinationByIdUseCase(
        destinationRepository: getIt<DestinationRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetDestinationsByCategoryUseCase>(
    () => GetDestinationsByCategoryUseCase(
        destinationRepository: getIt<DestinationRemoteRepository>()),
  );
  getIt.registerLazySingleton<GetDestinationsBySectionUseCase>(
    () => GetDestinationsBySectionUseCase(
        destinationRepository: getIt<DestinationRemoteRepository>()),
  );

  // Register Home Bloc
  getIt.registerFactory<DestinationBloc>(
    () => DestinationBloc(
      getAllDestinationsUseCase: getIt<GetAllDestinationsUseCase>(),
      getDestinationByIdUseCase: getIt<GetDestinationByIdUseCase>(),
      getDestinationsByCategoryUseCase:
          getIt<GetDestinationsByCategoryUseCase>(),
      getDestinationsBySectionUseCase: getIt<GetDestinationsBySectionUseCase>(),
    ),
  );
}

_initAccommodationDependencies() {
  // ==================Data Source =================//
  getIt.registerLazySingleton<AccommodationRemoteDataSource>(
    () => AccommodationRemoteDataSource(getIt<Dio>()),
  );

  // =========================== Repository ===========================
  getIt.registerLazySingleton<AccommodationRemoteRepository>(
    () => AccommodationRemoteRepository(getIt<AccommodationRemoteDataSource>()),
  );

  // =========================== Usecase ===========================
  getIt.registerLazySingleton<GetAccommodationByDestinationUseCase>(
    () => GetAccommodationByDestinationUseCase(
        accommodationRepository: getIt<AccommodationRemoteRepository>()),
  );

  // Register accommodation Bloc
  getIt.registerFactory<AccommodationBloc>(
    () => AccommodationBloc(
      getAccommodationByDestinationUseCase:
          getIt<GetAccommodationByDestinationUseCase>(),
    ),
  );
}

_initGuideDependencies() {
  // ==================Data Source =================//
  getIt.registerLazySingleton<GuideRemoteDataSource>(
    () => GuideRemoteDataSource(getIt<Dio>()),
  );

  // =========================== Repository ===========================
  getIt.registerLazySingleton<GuideRemoteRepository>(
    () => GuideRemoteRepository(getIt<GuideRemoteDataSource>()),
  );

  // =========================== Usecase ===========================
  getIt.registerLazySingleton<GetAllGuideUseCase>(
    () => GetAllGuideUseCase(guideRepository: getIt<GuideRemoteRepository>()),
  );

  // Register guide Bloc
  getIt.registerFactory<GuideBloc>(
    () => GuideBloc(
      getAllGuideUseCase: getIt<GetAllGuideUseCase>(),
    ),
  );
}

_initProfileDependencies() async {
  // Use case
  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  // BLoC - using registerFactory to ensure a new instance is created each time
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  // getIt.registerLazySingleton<LoginUseCase>(
  //   () => LoginUseCase(
  //     getIt<AuthLocalRepository>(),
  //   ),
  // );
  //==================== Token Shared Preferences ===============
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );
//======================usecases===============
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
