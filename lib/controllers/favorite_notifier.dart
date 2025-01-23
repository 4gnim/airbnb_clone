import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteNotifier extends ChangeNotifier {
  List<String> _favoriteIds = [];
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<String> get favorites => _favoriteIds;

  FavoriteNotifier() {
    loadFavorite();
  }

  void tooglefavorite(DocumentSnapshot place) async {
    String placeId = place.id;
    if (_favoriteIds.contains(placeId)) {
      _favoriteIds.remove(placeId);
      await _removeFavorite(placeId);
    } else {
      _favoriteIds.add(placeId);
      await _addFavorites(placeId);
    }
  }

  bool isExist(DocumentSnapshot place) {
    return _favoriteIds.contains(place.id);
  }

  Future<void> _addFavorites(String placeId) async {
    try {
      await firebaseFirestore
          .collection('userFavorites')
          .doc(placeId)
          .set({'isFavorite': true});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _removeFavorite(String placeId) async {
    try {
      await firebaseFirestore.collection('userFavorites').doc(placeId).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loadFavorite() async {
    try {
      QuerySnapshot snapshot =
          await firebaseFirestore.collection('userFavorites').get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  static FavoriteNotifier of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteNotifier>(
      context,
      listen: listen,
    );
  }
}
