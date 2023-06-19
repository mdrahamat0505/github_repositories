import 'package:flutter/material.dart';
import 'package:github_repositories/services/repo.dart';
import 'package:url_launcher/url_launcher.dart';
class GithubItem extends StatelessWidget {
  final Repo repo;
  GithubItem(this.repo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {
            _launchURL(repo.htmlUrl);
          },
          highlightColor: Colors.lightBlueAccent,
          splashColor: Colors.red,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text((repo.name != null) ? repo.name : '-',
                      style: Theme.of(context).textTheme.bodySmall),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                        repo.description ?? 'No desription',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text((repo.owner != null) ? repo.owner : '',
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodySmall)),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.star,
                                color: Colors.deepOrange,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                    (repo.watchersCount != null)
                                        ? '${repo.watchersCount} '
                                        : '0 ',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodySmall),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Text(
                                (repo.language != null) ? repo.language : '',
                                textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.bodySmall)),
                      ],
                    ),
                  ),
                ]),
          )),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}