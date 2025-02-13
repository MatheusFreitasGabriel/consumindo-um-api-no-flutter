import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future getUserData()async{
    var response = await http.get(Uri.https("jsonplaceholder.typicode.com" ,'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for(var u in jsonData){
      User user = User(u["name"], u["email"], u["username"]);
       users.add(user);
    }
    
    print(users.length);
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        title: Text("Consumindo uma api no flutter"),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot){
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: CircularProgressIndicator.adaptive()
                  ),
                );
              }else{
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].userName),
                      trailing: Text(snapshot.data[index].email),
                    );
                  },
                );
              }
            },
          ),
        ),
      )
    );
  }
}

class User{
  final String name, email, userName;

  User(this.name, this.email, this.userName);
}