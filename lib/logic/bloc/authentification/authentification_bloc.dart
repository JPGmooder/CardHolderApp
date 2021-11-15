import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:card_holder_app_with_kistik_love/data/models/user_model.dart';
import '../authentification/authentification_events.dart';
import '../authentification/authentification_states.dart';
import '../../repository/authentification_repositroy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  CollectionReference usersCollections;
  AuthentificationBloc(this.usersCollections)
      : super(AuthentificationInitialState(usersCollections)) {
    on<Authentification_SignIn_Via_Google>((event, emit) async {
      try {
        emit.call(AuthentificationLoadingState());
        var loggedUser = await AuthentificationRepository.loginUser();
        if (loggedUser == null) throw Exception();
        var usersDoc = usersCollections.doc(loggedUser.id);
        // TODO Сделать имплементацию ошибок через создание кастомных, пока оставлю как есть;
        if (await checkIfDocumentExist(usersDoc) == false) {
          usersDoc.set(loggedUser.toMapForDB());
        } else {
          var Cards = await getUsersCards(usersDoc);
          print(Cards);
          loggedUser.usersBankCards = Cards[0];
          loggedUser.usersMarkedCards = Cards[1]; // TODO Переделать
        }
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

  Future<List<dynamic>> getUsersCards(DocumentReference usersDoc) async {
    var fetchedData = await usersDoc.get();
    var convertedData = fetchedData.data() as Map<String, dynamic>;
    List<BankCards> usersBankCards =
        (convertedData['usersBankCards'] as List<dynamic>? ?? [])
            .map((e) => BankCards.fromMap(e))
            .toList();
    List<MarketCards> usersDiscountCards =
        (convertedData['usersMarkedCards'] as List<dynamic>? ?? [])
            .map((e) => MarketCards.fromMap(e))
            .toList();
    return [usersBankCards, usersDiscountCards];
  }

  void logIn() {
    add(Authentification_SignIn_Via_Google());
    // await Future.doWhile( () => state is! Authentification_LogedIn_Via_Google);
  }

  static Future<bool> checkIfDocumentExist(
      DocumentReference usersCollection) async {
    try {
      bool exists = false;
      await usersCollection.get().then((doc) {
        exists = doc.exists;
      });
      return exists;
    } catch (e) {
      // If any error
      return false;
    }
  }
}
