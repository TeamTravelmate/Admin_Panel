import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:travel_mate_admin/panel_left/circle_graph.dart';
import 'package:travel_mate_admin/constants.dart';
import 'package:travel_mate_admin/panel_left/curved_chart.dart';
import 'package:travel_mate_admin/panel_center/panel_center_page.dart';
import 'package:travel_mate_admin/responsive_layout.dart';
import '../Data/env.dart';

class TripController extends GetxController {
  var tripCount = 0.obs;

  @override
  void onInit() {
    fetchTrips();
    super.onInit();
  }

  Future<void> fetchTrips() async {
    var response = await get(Uri.parse('$backendUrl/admin/trips'));

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      print(decodedResponse);

      if (decodedResponse['trips'] != null) {
        tripCount.value = decodedResponse['trips'];
      } else {
        throw Exception('No trips found in the response');
      }
    } else {
      throw Exception('Failed to load trips');
    }
  }
}

class Todo {
  String name;
  bool enable;
  Todo({this.enable = true, required this.name});
}

class PanelLeftPage extends StatefulWidget {
  const PanelLeftPage({super.key});

  @override
  _PanelLeftPageState createState() => _PanelLeftPageState();
}

class _PanelLeftPageState extends State<PanelLeftPage> {
  final tripController = Get.put(TripController());

  List<Todo> _toDo = [
    // Todo(name: "Theia Bowen", color: Color(0xfff8b250)),
    Todo(name: "Check on Revenues", enable: true),
    Todo(name: "Approve Profile Upgrades", enable: true),
    Todo(name: "Take Action - Complaint", enable: true),
    Todo(name: "Add places", enable: true),
    Todo(name: "Approve ads", enable: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            if (ResponsiveLayout.isComputer(context))
              Container(
                color: Constants.purpleLight,
                width: 50,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Constants.purpleDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    ),
                  ),
                ),
              ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Constants.kPadding / 2,
                      right: Constants.kPadding / 2,
                      top: Constants.kPadding / 2,
                    ),
                    child: Card(
                      color: Constants.purpleLight,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: ListTile(
                          title: const Text(
                            "No of Total Trips",
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: const Text(
                            "2023 Jan - 2023 July",
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Chip(
                            label: Text(
                              "${tripController.tripCount.value}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 6, 6, 6)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const LineChartSample2(),
                  const PieChartSample2(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Constants.kPadding / 2,
                      right: Constants.kPadding / 2,
                      top: Constants.kPadding / 2,
                      bottom: Constants.kPadding,
                    ),
                    child: Card(
                      color: Constants.purpleLight,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: List.generate(
                          _toDo.length,
                          (index) => CheckboxListTile(
                              title: Text(
                                _toDo[index].name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              value: _toDo[index].enable,
                              onChanged: (newValue) {
                                setState(() {
                                  _toDo[index].enable == newValue ?? true;
                                });
                              }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
