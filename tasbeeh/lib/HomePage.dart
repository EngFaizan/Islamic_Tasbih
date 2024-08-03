import 'package:flutter/material.dart';
import 'AddNewTasbeeh.dart';
import 'DataBaseHelper.dart';
import 'TasbeehCounter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _tasbeehat = [];

  @override
  void initState() {
    super.initState();
    _loadTasbeehat();
  }

  Future<void> _loadTasbeehat() async {
    final dbHelper = DatabaseHelper();
    List<Map<String, dynamic>> tasbeehat = await dbHelper.getTasbeehat();
    setState(() {
      _tasbeehat = tasbeehat;
    });
  }

  void _navigateToAddTasbeeh() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTasbeehPage()),
    ).then((_) {
      _loadTasbeehat();
    });
  }

  void _navigateToTasbeehCounter(Map<String, dynamic> tasbeeh) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TasbeehCounter(
          id: tasbeeh['id'],
          tasbeeh: tasbeeh['tasbeeh'],
          maximumCount: tasbeeh['maxCount'],
          currentCount: tasbeeh['currentCount'],
          totalCycles: tasbeeh['totalCycles'],
        ),
      ),
    ).then((_) {
      _loadTasbeehat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Tasbeehat',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasbeehat.length,
              itemBuilder: (context, index) {
                var tasbeeh = _tasbeehat[index];
                return ListTile(
                  title: Text(tasbeeh['tasbeeh']),
                  subtitle: Text('Max Count: ${tasbeeh['maxCount']} | Cycles: ${tasbeeh['totalCycles']}'),
                  onTap: () => _navigateToTasbeehCounter(tasbeeh),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.3),
                side: const BorderSide(color: Colors.black, width: 2)
            ),
            onPressed: _navigateToAddTasbeeh,
            child: const Icon(Icons.add, color: Colors.deepPurple, size: 50,),
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
