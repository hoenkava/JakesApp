import 'dart:convert';

import 'package:assignment/models/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider with ChangeNotifier {
  SharedPreferences? prefs;
  bool allPagesFetched = false;
  bool firstLoad = false;
  bool loadingNewPage = true;
  int currentPage = 1;
  List<Repository> repositories = [];
  void init({required void Function() after}) async {
    prefs = await SharedPreferences.getInstance();
    after();
  }

  void loadRepos() async {
    var pageData = prefs!.getString('page${currentPage}');
    if (pageData != null) {
      var data = jsonDecode(pageData);
      if (data.length == 0) {
        allPagesFetched = true;
      }
      data.forEach((r) {
        repositories.add(Repository(
            name: r['name'],
            description: r['description'] ?? 'No description provided',
            language: r['language'],
            issues: r['open_issues'],
            people: r['watchers']));
      });
    } else {
      var resp = await get(
          Uri.parse(
              'https://api.github.com/users/JakeWharton/repos?page=$currentPage&per_page=15'),
          headers: {
            'Authorization': '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',
          });
      print(resp.request!.url.path);
      var data = jsonDecode(resp.body);
      print(resp.body);
      prefs!.setString('page${currentPage}', resp.body);
      if (data.isNotEmpty) {
        for (var element in data) {
          repositories.add(
            Repository(
                name: element['name'],
                description:
                    element['description'] ?? 'No description provided',
                language: element['language'],
                issues: element['open_issues'],
                people: element['watchers']),
          );
        }
      } else {
        allPagesFetched = true;
      }
    }
    firstLoad = true;
    loadingNewPage = false;
    notifyListeners();
  }
}
