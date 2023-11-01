import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:travel_mate_admin/constants.dart';
import 'package:travel_mate_admin/panel_center/linear_graph.dart';
import '../Data/env.dart';

class UserController extends GetxController {
  var users = List<Person>.empty(growable: true).obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

Future<void> fetchUsers() async {
  var response = await get(Uri.parse('$backendUrl/admin/viewUsers'));

  if (response.statusCode == 200) {
    var decodedResponse = jsonDecode(response.body);

    if (decodedResponse['users'] != null) {
      var random = Random();
      var userList = List<Person>.generate(
        decodedResponse['users'].length ~/ 4,
        (index) => Person(
          name: decodedResponse['users'][index * 4 + 1].toString(),
          color: Color.fromRGBO(
            random.nextInt(250),
            random.nextInt(246),
            random.nextInt(226),
            1,
          ),
        ),
      );

      users.assignAll(userList);
    } else {
      throw Exception('No users found in the response');
    }
  } else {
    throw Exception('Failed to load users');
  }
}

}

class Person {
  String name;
  Color color;
  Person({required this.name, required this.color});
}

class PanelCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                          Padding(
            padding: const EdgeInsets.only(
                top: Constants.kPadding / 2,
                right: Constants.kPadding / 2,
                left: Constants.kPadding / 2),
            child: Card(
              color: Constants.purpleLight,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                width: double.infinity,
                child: const ListTile(
                  //leading: Icon(Icons.sell),
                  title: Text(
                    "Net Revenue from Trips",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "2023 Jan - 2023 July",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Chip(
                    label: Text(
                      "20,500",
                      style: TextStyle(color: Color.fromARGB(255, 11, 11, 11)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const PieChartSample2(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: Constants.kPadding,
                      left: Constants.kPadding / 2,
                      right: Constants.kPadding / 2,
                      bottom: Constants.kPadding),
                  child: Card(
                    color: Constants.purpleLight,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: List.generate(
                        controller.users.length,
                        (index) => ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: controller.users[index].color,
                            child: Text(
                              controller.users[index].name.substring(0, 1),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            controller.users[index].name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.message,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
