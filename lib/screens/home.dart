import 'package:assignment/widgets/repo_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("  Jake's Git"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return RepoTile();
        },
      ),
    );
  }
}
