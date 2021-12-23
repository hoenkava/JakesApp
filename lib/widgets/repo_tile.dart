import 'package:assignment/models/repository.dart';
import 'package:flutter/material.dart';

class RepoTile extends StatelessWidget {
  final Repository repository;
  const RepoTile({required this.repository, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: [
              Icon(
                Icons.book,
                size: 50.0,
              ),
            ],
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  repository.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  repository.description,
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    if (repository.language != null) ...[
                      Icon(Icons.code),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        repository.language.toString(),
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                    Icon(Icons.bug_report),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      repository.issues.toString(),
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Icon(Icons.face),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      repository.people.toString(),
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
