import 'dart:convert';
import 'package:assignment/models/repository.dart';
import 'package:assignment/providers/data_provider.dart';
import 'package:assignment/providers/theme_provider.dart';
import 'package:assignment/widgets/repo_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<Repository> repositories = [];
  // bool firstLoad = false;
  // int currentPage = 1;
  // bool loadingNewPage = false;
  // bool allPagesFetched = false;
  @override
  void initState() {
    // TODO: implement initState
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);
    dataProvider.init(after: () {
      dataProvider.loadRepos();
    });
    // dataProvider.loadRepos();

    // loadRepos();
    super.initState();
  }

  // void loadRepos() async {
  //   var resp = await get(
  //       Uri.parse(
  //           'https://api.github.com/users/JakeWharton/repos?page=$currentPage&per_page=15'),
  //       headers: {
  //         'Authorization': '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',
  //       });
  //   print(resp.request!.url.path);
  //   var data = jsonDecode(resp.body);
  //   print(resp.body);
  //   if (data.isNotEmpty) {
  //     for (var element in data) {
  //       repositories.add(
  //         Repository(
  //             name: element['name'],
  //             description: element['description'] ?? 'No description provided',
  //             language: element['language'],
  //             issues: element['open_issues'],
  //             people: element['watchers']),
  //       );
  //     }
  //   } else {
  //     setState(() {
  //       allPagesFetched = true;
  //     });
  //   }
  //   setState(() {
  //     firstLoad = true;
  //     loadingNewPage = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);

    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            themeProvider.setDarkTheme(!themeProvider.isDarkTheme);
          },
          icon: Icon(themeProvider.isDarkTheme
              ? Icons.light_mode
              : Icons.nights_stay_outlined),
        ),
        title: const Text("  Jake's Git"),
      ),
      body: !dataProvider.firstLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : LazyLoadScrollView(
              onEndOfPage: () {
                if (!dataProvider.allPagesFetched &&
                    !dataProvider.loadingNewPage) {
                  dataProvider.currentPage++;
                  setState(() {
                    dataProvider.loadingNewPage = true;
                  });
                  dataProvider.loadRepos();
                }
              },
              scrollOffset: 100,
              child: Scrollbar(
                interactive: true,
                child: ListView.builder(
                  itemCount: dataProvider.repositories.length,
                  itemBuilder: (context, index) {
                    bool isLastElement =
                        dataProvider.repositories.length == index + 1;
                    if (dataProvider.loadingNewPage && isLastElement) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RepoTile(
                            // repository: Repository(
                            //     name: 'Vini', description: 'Hello from the other side'),
                            repository: dataProvider.repositories[index],
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                        ],
                      );
                    }
                    return RepoTile(
                      // repository: Repository(
                      //     name: 'Vini', description: 'Hello from the other side'),
                      repository: dataProvider.repositories[index],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
