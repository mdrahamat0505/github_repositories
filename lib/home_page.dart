import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_repositories/repositories_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     TextButton(onPressed: (){
    //   Get.to(RepositoriesDetails());
    //     }, child: const Text('Repositories'),)
    //   ],
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FloatingActionButton",
        ),
        backgroundColor: Colors.blue,
        // actions: const <Widget>[
        //   Text(
        //     "GFG",
        //     textScaleFactor: 3,
        //   )
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Get.to(() => const RepositoriesDetails());
          // Get.to(
          //   const RepositoriesDetails(),
          // );

          //Get.toNamed('/repositories_details');
          //Get.off(const RepositoriesDetails());
          //Get.offAll(const RepositoriesDetails());
          //Get.back();
          //Controller controller = Get.put(Controller()); // Rather Controller controller = Controller();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
