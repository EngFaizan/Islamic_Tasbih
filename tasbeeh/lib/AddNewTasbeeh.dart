import 'package:flutter/material.dart';
import 'DataBaseHelper.dart';

class AddTasbeehPage extends StatefulWidget {
  @override
  _AddTasbeehPageState createState() => _AddTasbeehPageState();
}

class _AddTasbeehPageState extends State<AddTasbeehPage> {
  final TextEditingController _tasbeehController = TextEditingController();
  final TextEditingController _countController = TextEditingController();

  Future<void> _saveTasbeeh() async {
    String tasbeeh = _tasbeehController.text;
    int? maxCount = int.tryParse(_countController.text);
    if (tasbeeh.isNotEmpty && maxCount != null) {
      final dbHelper = DatabaseHelper();
      await dbHelper.insertTasbeeh({
        'tasbeeh': tasbeeh,
        'maxCount': maxCount,
        'totalCycles': 0,
        'currentCount': 0,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Tasbeeh'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tasbeehController,
              decoration: const InputDecoration(labelText: 'Tasbeeh'),
            ),
            TextField(
              controller: _countController,
              decoration: const InputDecoration(labelText: 'Maximum Count'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTasbeeh,
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
