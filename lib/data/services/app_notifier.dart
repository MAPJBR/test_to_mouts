import 'dart:convert';
import 'package:books/data/data_drivers/api/api.dart';
import 'package:books/data/model/books.dart';
import 'package:books/data/model/detail_model.dart';
import 'package:flutter/cupertino.dart';

class AppNotifier extends ChangeNotifier {
  AppNotifier({required this.bookApi});
  final BookApi bookApi;
//Main api Books
  Future<Books> getBookData() async {
    var res = await bookApi.getBooks();

    var data = jsonDecode(res);

    return Books.fromJson(data);
  }

//Anime Books
  Future<Books> getBookData2() async {
    var res = await bookApi.getBooks2();
    var data = jsonDecode(res);

    return Books.fromJson(data);
  }

//Adventure Books
  Future<Books> getBookData3() async {
    var res = await bookApi.getBooks3();
    var data = jsonDecode(res);

    return Books.fromJson(data);
  }

  //Novel
  Future<Books> getBookData4() async {
    var res = await bookApi.getBooks4();
    var data = jsonDecode(res);

    return Books.fromJson(data);
  }

  //Horror Books
  Future<Books> getBookData5() async {
    var res = await bookApi.getBooks5();
    var data = jsonDecode(res);

    return Books.fromJson(data);
  }

//Searching Books
  Future<Books> searchBookData({required String searchBook}) async {
    var res = await bookApi.searchBooks(searchBook: searchBook);
    //print(res);
    var data = jsonDecode(res);

    return Books.fromJson(data);
  }

//Showing Particular Book Details
  Future<DetailModel> showBookData({required String id}) async {
    var res = await bookApi.showBooksDetails(id: id);
    var data = jsonDecode(res);

    return DetailModel.fromJson(data);
  }
}
