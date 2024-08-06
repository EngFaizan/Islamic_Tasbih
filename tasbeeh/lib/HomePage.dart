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
      body: Container(
        color: Colors.lightBlue,
        child: Column(
          children: [
            Image.asset('assets/images/masjid.webp'),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tasbeehat.length,
                itemBuilder: (context, index) {
                  var tasbeeh = _tasbeehat[index];
                  return Card(
                    color: Colors.purple,
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(tasbeeh['tasbeeh'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text('Max Count: ${tasbeeh['maxCount']}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      trailing: Text('Cycles: ${tasbeeh['totalCycles']}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      onTap: () => _navigateToTasbeehCounter(tasbeeh),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  side: const BorderSide(color: Colors.black, width: 2)
              ),
              onPressed: _navigateToAddTasbeeh,
              child: const Icon(Icons.add, color: Colors.deepPurple, size: 50,),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
