import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyagevue/app/shared_prefs/token_shared_prefs.dart';
import 'package:voyagevue/core/network/api_service.dart';
import 'package:voyagevue/core/network/hive_service.dart';
import 'package:voyagevue/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:voyagevue/features/auth/data/data_source/remote_data_sourse/auth_remote_data_source.dart';
import 'package:voyagevue/features/auth/data/repository/auth_local_repository.dart';
import 'package:voyagevue/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:voyagevue/features/auth/domain/usecase/login_usecase.dart';
import 'package:voyagevue/features/auth/domain/usecase/register_usecase.dart';
import 'package:voyagevue/features/auth/domain/usecase/upload_image_usecase.dart';
import 'package:voyagevue/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:voyagevue/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:voyagevue/features/home/presentation/view_model/home_cubit.dart';
import 'package:voyagevue/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

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
  getIt.registerLazySingleton<SharedPreferences>(( )=> sharedPreferences);
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
