import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBox(Icons.rocket_launch, 'PROJETOS', 0),
              SizedBox(height: 20),
              buildBox(Icons.report, 'AVISOS', 1),
              SizedBox(height: 20),
              buildBox(Icons.date_range, 'AGENDAMENTO', 2),
              SizedBox(height: 20),
              buildBox(Icons.fingerprint, 'ACESSOS', 3),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
              color: Colors.black,
            ),
            BottomAppBar(
              child: Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildIconContainer(Icons.explore, 0),
                    buildIconContainer(Icons.person, 1),
                    buildIconContainer(Icons.help_outline, 2),
                  ],
                ),
              ),
              elevation: 1,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconContainer(IconData icon, int index) {
    bool isSelected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          color: isSelected ? Colors.green[700] : Colors.white,
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.green[700],
            size: 50,
          ),
        ),
      ),
    );
  }

  Widget buildBox(IconData icon, String text, int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 50,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
