
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:password_manager/models/password_model.dart';
import 'package:password_manager/views/widgets/toast.dart';

part 'local_auth_event.dart';
part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc() : super(LocalAuthInitial()) {
    on<LocalAuthenticationEvent>((event, emit) async {
      try {
        final LocalAuthentication auth = LocalAuthentication();

        bool biometricIsAvailable = await auth.canCheckBiometrics;
        log("Biometric $biometricIsAvailable");
        if (biometricIsAvailable) {
          final bool didAuthenticated = await auth.authenticate(
            localizedReason: "Please authenticate to show secret string",
            options: const AuthenticationOptions(biometricOnly: false),
          );
          if (didAuthenticated) {
            emit(AuthSuccessState(model: event.model));
          }else{
            emit(AuthErrorState());
          }
        }
      } catch (e) {
        emit(AuthSuccessState(model: event.model));
        // flutterToast(msg: "Biometrics not set up on this device, Please set up biometrics");
        log(e.toString());
      }
    });
  }
}
