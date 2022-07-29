import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../services/user_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List> users = getUsers();
  final TextEditingController _searchController = TextEditingController();

  searchUser() {
    users = searchUsers(_searchController.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Api Integration")),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
                hintText: "Search By Name",
                suffix: IconButton(
                  onPressed: () => searchUser(),
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                )),
          ),
          Expanded(
            child: FutureBuilder(
              future: users,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            "${snapshot.data[index].name} - (${snapshot.data[index].username})"),
                        subtitle: Text(
                            "${snapshot.data[index].email} - (${snapshot.data[index].phone})"),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}