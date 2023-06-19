import 'package:flutter/material.dart';
import 'package:github_repositories/services/api_service.dart';
import 'package:github_repositories/services/repo.dart';

import 'components/search.dart';
import 'item.dart';

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Repo> _repos = [];
  bool _isFetching = false;
  late String _error;

  @override
  void initState() {
    super.initState();
    loadTrendingRepos();
  }

  void loadTrendingRepos() async {
    setState(() {
      _isFetching = true;
      _error = '';
    });

    final repos = await ApiService.getTrendingRepositories();
    setState(() {
      _isFetching = false;
      if (repos != null) {
        this._repos = repos;
      } else {
        _error = 'Error fetching repos';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: const EdgeInsets.only(top: 4.0),
            child: Column(
              children: <Widget>[
                Text('Github Repos',
                    style: Theme
                        .of(context)
                        .textTheme.displaySmall?.apply(color: Colors.white)),
                // Text('Trending',
                //     style: Theme
                //         .of(context)
                //         .textTheme
                //         .subhead
                //         .apply(color: Colors.white))
              ],
            )),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchList(),
                    ));
              }),
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    if (_isFetching) {
      return Container(
          alignment: Alignment.center, child: const Icon(Icons.timelapse));
    } else if (_error != null) {
      return Container(
          alignment: Alignment.center,
          child: Text(
            _error,
            style: Theme.of(context).textTheme.displaySmall,
          ));
    } else {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _repos.length,
          itemBuilder: (BuildContext context, int index) {
            return GithubItem(_repos[index]);
          });
    }
  }
}

