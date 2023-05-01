import 'package:books/presentation/widgets/books/consts/consts_to_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/constants/constants.dart';
import '../../data/services/app_notifier.dart';
import '../../data/model/books.dart';
import 'detail_screen.dart';

class CustomSearchDelegate extends SearchDelegate {
  String errorLink = ConstsToBook.errosLink;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.searchBookData(searchBook: query),
          builder: (context, AsyncSnapshot<Books> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Opps! Try again later!"),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.items?.length,
                itemBuilder: (context, index) {
                  var authors =
                      snapshot.data?.items![index].volumeInfo?.authors ?? [];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                    id: snapshot.data?.items?[index].id,
                                    boxColor: AppColors.lightBlue,
                                  )));
                    },
                    leading: Image.network(snapshot.data?.items?[index]
                            .volumeInfo?.imageLinks?.thumbnail ??
                        errorLink),
                    title: Text(
                      authors.isNotEmpty ? authors[0] : "Not Found",
                    ),
                    subtitle: Text(
                      "${snapshot.data?.items![index].volumeInfo?.title}",
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
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.searchBookData(searchBook: "Biography"),
          builder: (context, AsyncSnapshot<Books> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Opps! Try again later!"),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  var authors =
                      snapshot.data?.items![index].volumeInfo?.authors ?? [];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            id: snapshot.data?.items?[index].id,
                            boxColor: AppColors.lightBlue,
                          ),
                        ),
                      );
                    },
                    leading: Image.network(
                      snapshot.data?.items?[index].volumeInfo?.imageLinks
                              ?.thumbnail ??
                          errorLink,
                    ),
                    title: Text(
                      authors.isNotEmpty ? authors[0] : "Not Found",
                    ),
                    subtitle: Text(
                        "${snapshot.data?.items![index].volumeInfo?.title}"),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.black,
              ),
            );
          },
        );
      },
    );
  }
}
