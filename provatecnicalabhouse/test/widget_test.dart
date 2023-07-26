// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import 'package:provatecnicalabhouse/main.dart';
import 'package:provatecnicalabhouse/src/app.dart';
import 'package:provatecnicalabhouse/src/config/routes/navigator_routes.dart';

void main() {

  test("description", () async {

    final encoded = Latin1Codec().encode("TradiciÃ³n noruega de disfrazarse y visitar a los vecinos durante las vacaciones de Navidad.");

    print(utf8.decode(encoded).toString());

    // http.Response response = await http.get(
    //     Uri.parse("https://www.google.com/search?sxsrf=AB5stBj6qR4to_Y-GpUJ5RKo9FVhpUQNRQ:1690244322853&q=diamante&tbm=isch&source=lnms&sa=X&ved=2ahUKEwiAyMnjyqiAAxXs_rsIHagZCewQ0pQJegQIDRAB&cshid=1690244342610269&biw=1920&bih=937&dpr=1")
    // );
    //
    // print("response.body");
    // // print(response.body);
    // // print(response.body.indexOf('https://encr'));
    //
    // String tmpUrl = response.body.substring(response.body.indexOf('https://encr'));
    //
    // print(tmpUrl.substring(0, tmpUrl.indexOf('\"')));


  });

}
