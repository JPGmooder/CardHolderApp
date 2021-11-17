import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:card_holder_app_with_kistik_love/data/models/user_model.dart';
import 'package:card_holder_app_with_kistik_love/logic/database_checks.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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

        var usersDoc = usersCollections.doc(loggedUser
            .id); //* Получаем запись в таблице на пользователя по его id (Если записи нет - null)
        // TODO Сделать имплементацию ошибок через создание кастомных, пока оставлю как есть;
        if (await DatabaseChecks.checkIfDocumentExist(usersDoc) ==
            false) //* Проверка есть ли запись
        {
          usersDoc.set(loggedUser.toMapForDB()); //* Добавление новой записи
        } else {
          var _cards = await DatabaseChecks.getUsersCards(
              usersDoc); //* Получаем карты пользователя мапой

          loggedUser.usersBankCards = _cards[DatabaseChecks.dbBankCardsName];
          loggedUser.usersMarkedCards =
              _cards[DatabaseChecks.dbMarketCardsName]; // TODO Переделать
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

  void logIn() {
    add(Authentification_SignIn_Via_Google());
    // await Future.doWhile( () => state is! Authentification_LogedIn_Via_Google);
  }
}
