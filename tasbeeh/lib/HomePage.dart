import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
            child: Text(widget.title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.black87
              ),
            )
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/masjid.webp'),
              Expanded(
                child: Container(
                  // decoration: const BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage('assets/images/background.png'),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'You have read your tasbeeh this many time(s):',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          '$_counter',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.deepPurple,
                              fontSize: 100,
                              fontWeight: FontWeight.w900
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _incrementCounter,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.3),
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(70),
                              side: const BorderSide(color: Colors.black, width: 3)
                          ),
                          child: const Text('Add Count',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20), // Added some space between buttons
              ElevatedButton(
                onPressed: _resetCounter,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    side: const BorderSide(color: Colors.black, width: 3)
                ),
                child: const Text('Reset Count',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900
                  ),
                ),
              ),
              const SizedBox(height: 20), // Added some space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}