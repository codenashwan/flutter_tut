import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

const api = "http://192.168.1.25/api/";

class _HomeState extends State<Home> {
  Future getData() async {
    var url = Uri.parse("$api");
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  @override
  initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
          size: 24,
        ),
        title: SvgPicture.asset(
          'assets/img/logo.svg',
          width: 60,
          height: 30,
          fit: BoxFit.cover,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 2, 20, 0),
            child: Icon(
              Icons.search,
              color: Color(0xFF2F2E2E),
              size: 24,
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFEAE9EE),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: FutureBuilder(
              future: getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GridView.builder(
                    itemCount: snapshot.data.length ?? 2,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, i) {
                      if (snapshot.hasData) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/quotes',
                                arguments: {'user_id': snapshot.data[i]['id']});
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF5F5F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    '$api/upload/profile/' +
                                        snapshot.data[i]['image'],
                                  ),
                                ),
                                Text(
                                  snapshot.data[i]['name'],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFE76E54),
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text("Empty..."),
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator()));
                }
              },
            )),
      ),
    );
  }
}
