import 'package:books/app/constants/constants.dart';
import 'package:books/domain/use_cases/favorite.dart';
import 'package:books/data/model/detail_model.dart';
import 'package:books/presentation/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class MyFavorites extends StatefulWidget {
  const MyFavorites({Key? key}) : super(key: key);

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  final _random = math.Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "My favorites",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Consumer<FavoritesNotifier>(builder: ((context, value, child) {
        return FutureBuilder(
            future: value.getAllFavorites(),
            builder: (context, AsyncSnapshot<List<DetailModel>> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Opps! Try again later!"),
                );
              }
              if (snapshot.hasData) {
                var favorites = snapshot.data!;
                return GridView.builder(
                  itemCount: favorites.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 260,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: GestureDetector(
                        onTap: () {
                          // print(index);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                id: favorites[index].id,
                                boxColor: boxColors[_random.nextInt(7)],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: LayoutBuilder(builder: (context, constraints) {
                            var authors =
                                favorites[index].volumeInfo?.authors ?? [];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: constraints.maxHeight / 2,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        height: constraints.maxHeight / 2.5,
                                        decoration: BoxDecoration(
                                            color:
                                                boxColors[_random.nextInt(7)],
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      Positioned(
                                        top: 0,
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: SizedBox(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image(
                                                height:
                                                    constraints.maxHeight / 2,
                                                width: constraints.maxWidth / 2,
                                                image: NetworkImage(
                                                  "${favorites[index].volumeInfo!.imageLinks!.thumbnail}",
                                                ),
                                                fit: BoxFit.fill, // use this
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        authors.isNotEmpty
                                            ? authors[0]
                                            : "Not Found",
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                              fontSize:
                                                  constraints.maxWidth * 0.09,
                                            ),
                                      ),
                                      Text(
                                        "${favorites[index].volumeInfo?.title}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                fontSize:
                                                    constraints.maxWidth * 0.09,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * 0.13,
                                        width: constraints.maxWidth * 0.35,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: AppColors.black,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Text(
                                          "\$${favorites[index].volumeInfo?.pageCount}",
                                          style: TextStyle(
                                              fontSize:
                                                  constraints.maxWidth * 0.08,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.black,
                ),
              );
            });
      })),
    );
  }
}
