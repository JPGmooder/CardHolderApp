import 'package:card_holder_app_with_kistik_love/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseChecks {
  static const String dbBankCardsName = 'usersBankCards';
  static const String dbMarketCardsName = 'usersMarkedCards';
  static const String dbBankCardImagePath = '/bank_cards_images';
  static const String dbMarketCardImagePath = '/discount_cards_images';

  static Future<String> getImage(String pathToImage) async =>
      FirebaseStorage.instance.ref(pathToImage).getDownloadURL();

  static Future<bool> checkIfDocumentExist(
      DocumentReference usersCollection) async {
    try {
      bool exists = false;
      await usersCollection.get().then((doc) {
        exists = doc.exists;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> getUsersCards(
      DocumentReference usersDoc) async {
    var fetchedData = await usersDoc.get();
    var convertedData = fetchedData.data() as Map<String, dynamic>;
    List<BankCards> usersBankCards =
        (convertedData[dbBankCardsName] as List<dynamic>? ?? [])
            .map((e) => BankCards.fromMap(e))
            .toList();
    usersBankCards.forEach((element) async {
      element.imagePath = await getImage(element.imagePath);
    });
    List<MarketCards> usersDiscountCards =
        (convertedData[dbMarketCardsName] as List<dynamic>? ?? [])
            .map((e) => MarketCards.fromMap(e))
            .toList();
    usersDiscountCards.forEach((element) async {
      element.image = await getImage(element.image);
    });
    return {
      dbBankCardsName: usersBankCards,
      dbMarketCardsName: usersDiscountCards
    };
  }
}
