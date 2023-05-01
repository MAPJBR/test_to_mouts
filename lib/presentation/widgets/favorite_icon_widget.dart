import 'package:books/app/constants/constants.dart';
import 'package:books/domain/use_cases/favorite.dart';
import 'package:books/data/model/detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteIconWidget extends StatelessWidget {
  const FavoriteIconWidget({
    super.key,
    this.item,
  });

  final DetailModel? item;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesNotifier>(
      builder: ((context, value, child) {
        return FutureBuilder(
            future: value.isFavorite(item),
            builder: (context, AsyncSnapshot<bool> snap) {
              var isFavorite = snap.data ?? false;
              return OutlinedButton.icon(
                onPressed: () {
                  value.setFavorite(
                    item!,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(width: 1),
                ),
                icon: isFavorite
                    ? Icon(
                        Icons.favorite,
                        color: AppColors.black,
                      )
                    : Icon(
                        Icons.favorite_outline,
                        color: AppColors.black,
                      ),
                label: Text(
                  "FAVORITE",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              );
            });
      }),
    );
  }
}
