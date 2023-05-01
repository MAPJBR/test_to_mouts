import 'dart:convert';
import 'package:books/data/data_drivers/db/local.dart';
import 'package:books/data/model/detail_model.dart';
import 'package:flutter/material.dart';

class FavoritesNotifier extends ChangeNotifier {
  //Set Favorite List in device
  setFavorite(DetailModel item) async {
    var getFavorites = await DBLocal.getStringList('Favorites');
    var favorites = getFavorites
        .map((e) => DetailModel.fromJson(
              json.decode(e),
            ))
        .toList();
    getFavorites.add(json.encode(item.toJson()));

    if (favorites.where((e) => e.id == item.id).isEmpty) {
      await DBLocal.saveStringList('Favorites', getFavorites);
    } else {
      favorites.removeWhere((e) => e.id == item.id);

      await DBLocal.saveStringList(
        'Favorites',
        favorites.map((e) {
          return json.encode(e.toJson());
        }).toList(),
      );
    }
    notifyListeners();
  }

  //get Favorite List in device
  Future<List<DetailModel>> getAllFavorites() async {
    var getFavorites = await DBLocal.getStringList('Favorites');
    var favorites = getFavorites.map(
      (e) => DetailModel.fromJson(
        json.decode(e),
      ),
    );
    return favorites.toList();
  }

  Future<bool> isFavorite(DetailModel? item) async {
    var getFavorites = await DBLocal.getStringList('Favorites');
    var favorites = getFavorites.map(
      (e) => DetailModel.fromJson(
        json.decode(e),
      ),
    );
    return item != null ? favorites.any((e) => e.id == item.id) : false;
  }
}
