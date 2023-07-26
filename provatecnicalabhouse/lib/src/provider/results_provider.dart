import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provatecnicalabhouse/src/api/request_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Result.dart';
import '../models/explorers.dart';

class ResultsProvider extends ChangeNotifier {
  int value = 0;
  List<Result>? _results;
  Map<String, List<Result>>? _pastResults = null;
  Explorer _explorer = Explorer.Hange;

  late SharedPreferences _sharedPreferences;

  Explorer get explorer => _explorer;
  String prompt = "";

  List<Result>? get results => _results;

  Future getUserDataFromSharedPreferences() async {
    _pastResults = null;
    notifyListeners();

    _sharedPreferences = await SharedPreferences.getInstance();

    try {
      if (_sharedPreferences.containsKey("past_results")) {
        print(
            "jsonDecode(_sharedPreferences.getString(\"past_results\")!).runtimeType");
        print(jsonDecode(_sharedPreferences.getString("past_results")!)
            .runtimeType);

        _pastResults = Map();

        (jsonDecode(_sharedPreferences.getString("past_results")!)
                as Map<String, dynamic>)
            .forEach((key, value) {
          List<Result> tmpList = [];

          (value as List<dynamic>).forEach((element) {
            tmpList.add(Result.fromJson(element));
          });

          _pastResults?.putIfAbsent(key, () => tmpList);
        });
      } else {
        print("Shared preferences does not contain data for \"past_results\"");
      }
    } catch (e, s) {
      print("ERROR getUserDataFromSharedPreferences: $e");
      print(s);
      rethrow;
    }

    notifyListeners();
  }

  _setResults({required List<Result>? results, String? prompt}) {
    _results = results;

    notifyListeners();
  }

  setExplorer({required Explorer explorer}) {
    _explorer = explorer;

    notifyListeners();
  }

  fetchResults({required String prompt, List<Result>? pastResults}) async {
    _setResults(results: null);
    this.prompt = prompt;
    notifyListeners();

    List<Result> tmpResults = await RequestProvider.getResults(
        prompt: prompt, model: _explorer.model, pastResults: pastResults);

    if (pastResults == null) {
      if (_pastResults == null) {
        _pastResults = Map();
      }

      _pastResults?.putIfAbsent(
          "${DateTime.now().toString()}", () => tmpResults);

      _updateSharedPreferences();
    }
    _setResults(results: tmpResults);
    notifyListeners();
  }

  void _updateSharedPreferences() async {
    print("jsonEncode(_pastResults)");
    print(jsonEncode(_pastResults));

    await _sharedPreferences.setString(
        "past_results", jsonEncode(_pastResults));
  }

  Map<String, List<Result>>? get pastResults => _pastResults;
}
