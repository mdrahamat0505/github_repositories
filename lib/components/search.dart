import 'package:flutter/material.dart';
import 'package:github_repositories/services/api_service.dart';
import 'dart:async';
import '../item.dart';
import '../services/repo.dart';

class SearchList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchList> {
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _error ="";
  List<Repo> _results = [];

  Timer debounceTimer = Timer(const Duration(milliseconds: 500), () {});


  _SearchState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(const Duration(milliseconds: 500), () {
        if (this.mounted) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _SearchState();
    super.initState();
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _error = '';
        _results = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = '';
      _results = [];
    });

    final repos = await ApiService.getRepositoriesWithSearchQuery(query);
    if (this._searchQuery.text == query && this.mounted) {
      setState(() {
        _isSearching = false;
        if (repos != null) {
          _results = repos;
        } else {
          _error = 'Error searching repos';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: AppBar(
          centerTitle: true,
          title: TextField(
            autofocus: true,
            controller: _searchQuery,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(end: 16.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                hintText: "Search repositories...",
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ),
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return CenterTitle('Searching Github...');
    } else if (_error != null) {
      return CenterTitle(_error);
    } else if (_searchQuery.text.isEmpty) {
      return CenterTitle('Begin Search by typing on search bar');
    } else {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _results.length,
          itemBuilder: (BuildContext context, int index) {
            return GithubItem(_results[index]);
          });
    }
  }
}

class CenterTitle extends StatelessWidget {
  final String title;

  CenterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ));
  }
}
