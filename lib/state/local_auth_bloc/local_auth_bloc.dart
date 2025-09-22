import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'local_auth_event.dart';
part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc() : super(LocalAuthInitial()) {
    on<LocalAuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
