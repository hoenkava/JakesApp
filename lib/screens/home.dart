import 'package:assignment/models/repository.dart';
import 'package:assignment/widgets/repo_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("  Jake's Git"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return RepoTile(
            repository: Repository(
                name: 'Vini', description: 'Hello from the other side'),
          );
        },
      ),
    );
  }
}
