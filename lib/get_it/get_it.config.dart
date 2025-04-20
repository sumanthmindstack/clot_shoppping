// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/repository/auth_repo_impl.dart' as _i231;
import '../domain/repository/auth/auth_repo.dart' as _i971;
import '../presentation/auth/bloc/age_selection_cubit/age_selection_cubit.dart'
    as _i781;
import '../presentation/auth/bloc/gender_selection_cubit.dart' as _i853;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i781.AgeSelectionCubit>(() => _i781.AgeSelectionCubit());
  gh.factory<_i853.GenderSelectionCubit>(() => _i853.GenderSelectionCubit());
  gh.lazySingleton<_i971.AuthRepo>(() => _i231.AuthRepoImpl());
  return getIt;
}
