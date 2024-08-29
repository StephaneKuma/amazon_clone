// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:amazon_clone/src/services/authentication_service.dart' as _i466;
import 'package:amazon_clone/src/services/category_service.dart' as _i927;
import 'package:amazon_clone/src/services/http_service.dart' as _i194;
import 'package:amazon_clone/src/services/user_service.dart' as _i1012;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i194.HttpService>(() => _i194.HttpService());
    gh.lazySingleton<_i466.AuthenticationService>(
        () => _i466.AuthenticationService());
    gh.lazySingleton<_i927.CategoryService>(() => _i927.CategoryService());
    gh.lazySingleton<_i1012.UserService>(() => _i1012.UserService());
    return this;
  }
}
