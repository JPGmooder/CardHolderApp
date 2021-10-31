import 'package:bloc/bloc.dart';
import '../authentification/authentification_events.dart';
import '../authentification/authentification_states.dart';
import '../../repository/authentification_repositroy.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  AuthentificationBloc() : super(AuthentificationInitialState()) {
    on<Authentification_SignIn_Via_Google>((event, emit) async {
      try {
        emit.call(AuthentificationLoadingState());
        var loggedUser = await AuthentificationRepository.loginUser();
        if (loggedUser == null) throw Exception();
        // TODO Сделать имплементацию ошибок через создание кастомных, пока оставлю как есть;
        emit.call(Authentification_LogedIn_Via_Google(loggedUser));
      } catch (error) {
        throw error;
        // TODO addError(); Сделать имплементацию ошибок через создание кастомных, пока оставлю как есть;
      }
    });

    on<Authentification_LogOut_Via_Google>((event, emit) async {
      emit.call(AuthentificationLoadingState());
      await AuthentificationRepository.logOut();
      emit.call(Authentification_LogedOut_Via_Google());
    });
  }
}
