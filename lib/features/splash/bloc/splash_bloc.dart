import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/repositories/auth_repository.dart';

enum SplashStatus { loading, authenticated, unauthenticated }

class SplashState extends Equatable {
  final SplashStatus status;

  const SplashState({required this.status});

  const SplashState.loading() : status = SplashStatus.loading;

  @override
  List<Object?> get props => [status];
}

class SplashBloc extends Cubit<SplashState> {
  final AuthRepository _authRepository;

  SplashBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SplashState.loading()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await Future<void>.delayed(
      const Duration(seconds: AppConstants.splashDelaySeconds),
    );

    if (_authRepository.isLoggedIn) {
      emit(const SplashState(status: SplashStatus.authenticated));
      return;
    }

    emit(const SplashState(status: SplashStatus.unauthenticated));
  }
}
