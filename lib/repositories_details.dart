import 'package:flutter/material.dart';

class RepositoriesDetails extends StatefulWidget {
  const RepositoriesDetails({super.key});

  @override
  State<RepositoriesDetails> createState() => _RepositoriesDetailsState();
}

class _RepositoriesDetailsState extends State<RepositoriesDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: const Text('Details')
    );
  }
}
