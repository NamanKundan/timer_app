import 'package:flutter/material.dart';

void main() => runApp(HomeAutomationApp());

class HomeAutomationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBulbOn = false;
  bool isSocketOn = false;

  // Timer values
  int timerValue = 0;

  // Scheduled time
  TimeOfDay scheduledTime = TimeOfDay.now();

  void toggleBulb() {
    setState(() {
      isBulbOn = !isBulbOn;
    });
  }

  void toggleSocket() {
    setState(() {
      isSocketOn = !isSocketOn;
    });
  }

  void setTimer(int value) {
    setState(() {
      timerValue = value;
    });
  }

  void scheduleTime(TimeOfDay time) {
    setState(() {
      scheduledTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Automation App'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Bulb'),
                Switch(
                  value: isBulbOn,
                  onChanged: (value) {
                    toggleBulb();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Socket'),
                Switch(
                  value: isSocketOn,
                  onChanged: (value) {
                    toggleSocket();
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Set Timer:',
              style: TextStyle(fontSize: 20.0),
            ),
            Slider(
              value: timerValue.toDouble(),
              min: 0,
              max: 60,
              onChanged: (value) {
                setTimer(value.toInt());
              },
            ),
            Text(
              '$timerValue minutes',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Schedule Time:',
              style: TextStyle(fontSize: 20.0),
            ),
            InkWell(
              onTap: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: scheduledTime,
                );
                if (selectedTime != null) {
                  scheduleTime(selectedTime);
                }
              },
              child: Row(
                children: <Widget>[
                  Text(
                    scheduledTime.format(context),
                    style: TextStyle(fontSize: 16.0),
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
