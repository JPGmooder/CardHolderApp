import 'package:card_holder_app_with_kistik_love/data/models/user_model.dart';
import 'package:card_holder_app_with_kistik_love/logic/bloc/user_interaction/user_events.dart';
import 'package:card_holder_app_with_kistik_love/logic/bloc/user_interaction/user_states.dart';
import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  User currentUser;
  UserBloc(this.currentUser) : super(UserLoadedState(currentUser)) {
    on<UserChangeAvaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
