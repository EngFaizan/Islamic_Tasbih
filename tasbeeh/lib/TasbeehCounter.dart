import 'package:flutter/material.dart';
import 'DataBaseHelper.dart';

class TasbeehCounter extends StatefulWidget {
  const TasbeehCounter({
    super.key,
    required this.id,
    required this.tasbeeh,
    required this.maximumCount,
    required this.currentCount,
    required this.totalCycles,
  });

  final int id;
  final String tasbeeh;
  final int maximumCount;
  final int currentCount;
  final int totalCycles;

  @override
  State<TasbeehCounter> createState() => TasbeehCounterState();
}

class TasbeehCounterState extends State<TasbeehCounter> {
  late int _counter;
  late int _cycles;

  @override
  void initState() {
    super.initState();
    _counter = widget.currentCount;
    _cycles = widget.totalCycles;
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
      if (_counter >= widget.maximumCount) {
        _counter = 0;
        _cycles++;
      }
    });
    final dbHelper = DatabaseHelper();
    await dbHelper.updateTasbeeh(widget.id, {
      'tasbeeh': widget.tasbeeh,
      'maxCount': widget.maximumCount,
      'currentCount': _counter,
      'totalCycles': _cycles,
    });
  }

  Future<void> _resetCounter() async {
    setState(() {
      _counter = 0;
    });
    final dbHelper = DatabaseHelper();
    await dbHelper.updateTasbeeh(widget.id, {
      'tasbeeh': widget.tasbeeh,
      'maxCount': widget.maximumCount,
      'currentCount': _counter,
      'totalCycles': _cycles,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Tasbeeh Counter",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            InkWell(
              onTap: () async {
                await DatabaseHelper().deleteTasbeeh(widget.id);
                Navigator.pop(context, true);
              },
              child: const Icon(Icons.delete),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/masjid.webp'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.tasbeeh,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Total Tasbeeh: $_cycles',
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'You have read your tasbeeh this many time(s):',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$_counter',
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _incrementCounter,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(70),
                          side: const BorderSide(color: Colors.black, width: 3),
                        ),
                        child: const Text(
                          'Add Count',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), // Added some space between buttons
                      ElevatedButton(
                        onPressed: _resetCounter,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          side: const BorderSide(color: Colors.black, width: 3),
                        ),
                        child: const Text(
                          'Reset Count',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), // Added some space at the bottom
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
