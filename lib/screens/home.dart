import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'history.dart';
import '../services/notification_service.dart';
import 'contact.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double sensorValue = 0.0;
  String fanStatus = "OFF";
  String alarmStatus = "OFF";
  double threshold = 0;
  bool flag=false;
  @override
  void initState() {
    super.initState();
    fetchFanAndAlarmStatus();
  }

  void fetchFanAndAlarmStatus() {
    DatabaseReference ref = FirebaseDatabase.instance.ref('device_status');
    DatabaseReference ref2 = FirebaseDatabase.instance.ref('example');

    ref2.child('value').onValue.listen((event){
      if (event.snapshot.value != null) {
        double newValue = double.parse(event.snapshot.value.toString());
        setState(() {
          threshold = newValue;
        });
      }
    });

    ref.child('fan').onValue.listen((event) {
      setState(() {
        fanStatus = event.snapshot.value.toString();
      });
    });

    ref.child('alarm').onValue.listen((event) {
      setState(() {
        alarmStatus = event.snapshot.value.toString();
      });
    });

    ref.child('sensorValue').onValue.listen((event) {
      if (event.snapshot.value != null) {
        double newValue = double.parse(event.snapshot.value.toString());
        setState(() {
          sensorValue = newValue;
        });
        if (sensorValue > threshold) {
          NotificationService.showNotification('Alert!', 'Gas Leakage Detected $sensorValue');
          sendDataToFireStore();
          setState((){
            flag=true;
          });
        }else{
          setState((){
            flag=false;
          });
        }
      }
    });
  }

  sendDataToFireStore() {
    FirebaseFirestore.instance.collection("sensorData").add({
      "value": sensorValue,
      "timestamp": FieldValue.serverTimestamp(),
    });
  }
  changeStatus(t){
    if(t=="Fan Status") {

        DatabaseReference ref = FirebaseDatabase.instance.ref('device_status');
        String status = fanStatus == "ON" ? "OFF" : "ON";
        ref.update({
          "fan": status,
        }).then((_) {
          print("Fan status update");
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gas Guard"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'About') {
                Navigator.pushNamed(context, '/about');
              }
              if(value == 'Contact'){
                Navigator.pushNamed(context,'/contact');
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return {'About', 'Contact'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("History"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 3, blurRadius: 7),
                ],
              ),
              child: Column(
                children: [
                  Text("Sensor Value", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(sensorValue.toString(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildStatusBox("Fan Status", fanStatus, fanStatus == "OFF" ? Colors.green : Colors.red),
                buildStatusBox("Alarm Status", alarmStatus, alarmStatus == "OFF" ? Colors.green : Colors.red),
              ],
            ),
            SizedBox(height: 20),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
                },
                child: Text("View History", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatusBox(String title, String status, Color color) {
    return GestureDetector(
      onTap: () {
        if (flag) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Warning"),
                content: Text("Fan cannot be off due to gas leakage"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }else{
          changeStatus(title);
        }
      },
      child: Container(
        width: 150,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 5),
          ],
        ),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(height: 10),
            Text(status, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }

}
