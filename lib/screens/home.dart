import 'dart:convert';

import 'package:assignment/models/repository.dart';
import 'package:assignment/widgets/repo_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Repository> repositories = [];
  bool firstLoad = false;
  int currentPage = 1;
  bool loadingNewPage = false;
  bool allPagesFetched = false;
  @override
  void initState() {
    // TODO: implement initState
    loadRepos();
    super.initState();
  }

  void loadRepos() async {
    var resp = await get(
        Uri.parse(
            'https://api.github.com/users/JakeWharton/repos?page=$currentPage&per_page=15'),
        headers: {
          'Authorization': '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',
        });
    print(resp.request!.url.path);
    var data = jsonDecode(resp.body);
    print(resp.body);
    if (data.isNotEmpty) {
      for (var element in data) {
        repositories.add(
          Repository(
              name: element['name'],
              description: element['description'] ?? 'No description provided',
              language: element['language'],
              issues: element['open_issues'],
              people: element['watchers']),
        );
      }
    } else {
      setState(() {
        allPagesFetched = true;
      });
    }
    setState(() {
      firstLoad = true;
      loadingNewPage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("  Jake's Git"),
      ),
      body: !firstLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : LazyLoadScrollView(
              onEndOfPage: () {
                if (!allPagesFetched && !loadingNewPage) {
                  currentPage++;
                  setState(() {
                    loadingNewPage = true;
                  });
                  loadRepos();
                }
              },
              scrollOffset: 100,
              child: Scrollbar(
                interactive: true,
                child: ListView.builder(
                  itemCount: repositories.length,
                  itemBuilder: (context, index) {
                    bool isLastElement = repositories.length == index + 1;
                    if (loadingNewPage && isLastElement) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RepoTile(
                            // repository: Repository(
                            //     name: 'Vini', description: 'Hello from the other side'),
                            repository: repositories[index],
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
                      repository: repositories[index],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
